import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/model/MovieData.dart';
import 'package:the_movies_flut/api/model/Person.dart';
import 'package:the_movies_flut/api/model/TVShow.dart';
import 'package:the_movies_flut/api/repository.dart';
import 'package:the_movies_flut/util/alog.dart';

class API {
  static final HttpClient _httpClient = HttpClient();
  static final String _urlBase = "api.themoviedb.org";
  static final String _urlPrefix = "/3";
  static final String _urlApiKey = "1f5b86b5d2ec241ec5863bc7941fad12";

  static String get urlBaseImage => "https://image.tmdb.org/t/p/w500";

  static Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      Alog.debug(uri);
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();

      Alog.debug(responseBody);

      return json.decode(responseBody);
    } on Exception catch (e) {
      Alog.debug('$e');
      return null;
    }
  }

  /// API from here
  static Future<List<MovieData>> getMovieListByType(
      ApiMovieListType type, int page) async {
    Uri uri;

    switch (type) {
      case ApiMovieListType.Playing:
        uri = Uri.https(_urlBase, _urlPrefix + '/movie/now_playing',
            {'page': page.toString(), 'api_key': _urlApiKey});
        break;

      case ApiMovieListType.Popularity:
        uri = Uri.https(_urlBase, _urlPrefix + '/discover/movie', {
          'page': page.toString(),
          'api_key': _urlApiKey,
          'sort_by': 'popularity.desc'
        });
        break;

      case ApiMovieListType.Ontv:
        uri = Uri.https(_urlBase, _urlPrefix + '/discover/tv', {
          'page': page.toString(),
          'api_key': _urlApiKey,
          'sort_by': 'popularity.desc'
        });
        break;

      case ApiMovieListType.Netflix:
        uri = Uri.https(_urlBase, _urlPrefix + '/movie/now_playing',
            {'page': page.toString(), 'api_key': _urlApiKey});
        break;
    }

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['status_code'] != null ||
        jsonResponse['status_message'] != null) {
      //TODO ERROR
      return null;
    }
    if (jsonResponse['results'] == null) {
      return List();
    }

    return MovieList.fromJson(jsonResponse).results;
  }

  static Future<DataListResult<List<MovieData>>> getMovieListByType2(
      ApiMovieListType type, int page) async {
    Uri uri;

    switch (type) {
      case ApiMovieListType.Playing:
        uri = Uri.https(_urlBase, _urlPrefix + '/movie/now_playing',
            {'page': page.toString(), 'api_key': _urlApiKey});
        break;

      case ApiMovieListType.Popularity:
        uri = Uri.https(_urlBase, _urlPrefix + '/discover/movie', {
          'page': page.toString(),
          'api_key': _urlApiKey,
          'sort_by': 'popularity.desc'
        });
        break;

      case ApiMovieListType.Ontv:
        uri = Uri.https(_urlBase, _urlPrefix + '/discover/tv', {
          'page': page.toString(),
          'api_key': _urlApiKey,
          'sort_by': 'popularity.desc'
        });
        break;

      case ApiMovieListType.Netflix:
        uri = Uri.https(_urlBase, _urlPrefix + '/movie/now_playing',
            {'page': page.toString(), 'api_key': _urlApiKey});
        break;
    }

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null ||
        jsonResponse['status_code'] != null ||
        jsonResponse['status_message'] != null) {
      //TODO ERROR
      return DataListResult(
          totalPages: 0,
          totalItems: 0,
          data: null,
          error: ErrorResult(jsonResponse['errors']));
    }
    if (jsonResponse['results'] == null) {
      return DataListResult(
          totalPages: 0, totalItems: 0, data: null, error: ErrorResult(""));
    }
    var fromJson = MovieList.fromJson(jsonResponse);
    return DataListResult(
        totalPages: fromJson.totalPages,
        totalItems: fromJson.totalResults,
        data: fromJson.results,
        error: ErrorResult(""));
  }

  static Future<DataListResult<List<TVShowData>>> getTVShowListByType2(
      ApiMovieListType type, int page) async {
    Uri uri;

    if (type == ApiMovieListType.Ontv) {
      uri = Uri.https(_urlBase, _urlPrefix + '/discover/tv', {
        'page': page.toString(),
        'api_key': _urlApiKey,
        'sort_by': 'popularity.desc'
      });
      final jsonResponse = await _getJson(uri);
      if (jsonResponse == null) {
        return null;
      }
      if (jsonResponse['errors'] != null ||
          jsonResponse['status_code'] != null ||
          jsonResponse['status_message'] != null) {
        //TODO ERROR
        return DataListResult(
            totalPages: 0,
            totalItems: 0,
            data: null,
            error: ErrorResult(jsonResponse['errors']));
      }
      if (jsonResponse['results'] == null) {
        return DataListResult(
            totalPages: 0, totalItems: 0, data: null, error: ErrorResult(""));
      }

      var fromJson = TVShowList.fromJson(jsonResponse);

      return DataListResult(
          totalPages: fromJson.totalPages,
          totalItems: fromJson.totalResults,
          data: fromJson.results,
          error: ErrorResult(""));
    } else {
      return null;
    }
  }

  static Future<List<TVShowData>> getTVShowListByType(
      ApiMovieListType type, int page) async {
    Uri uri;

    if (type == ApiMovieListType.Ontv) {
      uri = Uri.https(_urlBase, _urlPrefix + '/discover/tv', {
        'page': page.toString(),
        'api_key': _urlApiKey,
        'sort_by': 'popularity.desc'
      });
      final jsonResponse = await _getJson(uri);
      if (jsonResponse == null) {
        return null;
      }
      if (jsonResponse['status_code'] != null ||
          jsonResponse['status_message'] != null) {
        //TODO ERROR
        return null;
      }
      if (jsonResponse['results'] == null) {
        return List();
      }

      return TVShowList.fromJson(jsonResponse).results;
    } else {
      return null;
    }
  }

  static Future<DataListResult<List<Person>>>  getPopularPerson2(int page) async {
    Uri uri;
    uri = Uri.https(_urlBase, _urlPrefix + '/person/popular', {
      'page': page.toString(),
      'api_key': _urlApiKey,
    });
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }

    if (jsonResponse['errors'] != null ||
        jsonResponse['status_code'] != null ||
        jsonResponse['status_message'] != null) {
      //TODO ERROR
      return DataListResult(
          totalPages: 0,
          totalItems: 0,
          data: null,
          error: ErrorResult(jsonResponse['errors']));
    }
    if (jsonResponse['results'] == null) {
      return DataListResult(
          totalPages: 0, totalItems: 0, data: null, error: ErrorResult(""));
    }

    var fromJson = PersonList.fromJson(jsonResponse);

    return DataListResult(
        totalPages: fromJson.totalPages,
        totalItems: fromJson.totalResults,
        data: fromJson.results,
        error: ErrorResult(""));
  }

  static Future<List<Person>> getPopularPerson(int page) async {
    Uri uri;
    uri = Uri.https(_urlBase, _urlPrefix + '/person/popular', {
      'page': page.toString(),
      'api_key': _urlApiKey,
    });
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['status_code'] != null ||
        jsonResponse['status_message'] != null) {
      //TODO ERROR
      return null;
    }
    if (jsonResponse['results'] == null) {
      return List();
    }

    return PersonList.fromJson(jsonResponse).results;
  }
}
