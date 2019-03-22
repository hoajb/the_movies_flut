import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/model/MovieData.dart';
import 'package:the_movies_flut/api/model/Person.dart';
import 'package:the_movies_flut/api/model/TVShow.dart';
import 'package:the_movies_flut/util/alog.dart';

class API {
  static final HttpClient _httpClient = HttpClient();
  static final String _url_seedin = "qa.newunionplayground.com";
  static final String _url = "api.themoviedb.org";
  static final String _url_prefix = "/3";
  static final String _url_api_key = "1f5b86b5d2ec241ec5863bc7941fad12";

  static String get UrlBaseImage => "https://image.tmdb.org/t/p/w500";

  static Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
//      print(uri);
      Alog.debug(uri);
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.OK) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }

  /// API from here
  static Future<List<MovieData>> getMovieListByType(
      ApiMovieListType type, int page) async {
    Uri uri;

    switch (type) {
      case ApiMovieListType.Playing:
        uri = Uri.https(_url, _url_prefix + '/movie/now_playing',
            {'page': page.toString(), 'api_key': _url_api_key});
        break;

      case ApiMovieListType.Popularity:
        uri = Uri.https(_url, _url_prefix + '/discover/movie', {
          'page': page.toString(),
          'api_key': _url_api_key,
          'sort_by': 'popularity.desc'
        });
        break;

      case ApiMovieListType.Ontv:
        uri = Uri.https(_url, _url_prefix + '/discover/tv', {
          'page': page.toString(),
          'api_key': _url_api_key,
          'sort_by': 'popularity.desc'
        });
        break;

      case ApiMovieListType.Netflix:
        uri = Uri.https(_url, _url_prefix + '/movie/now_playing',
            {'page': page.toString(), 'api_key': _url_api_key});
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

  static Future<List<TVShowData>> getTVShowListByType(
      ApiMovieListType type, int page) async {
    Uri uri;

    if (type == ApiMovieListType.Ontv) {
      uri = Uri.https(_url, _url_prefix + '/discover/tv', {
        'page': page.toString(),
        'api_key': _url_api_key,
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

  static Future<List<Person>> getPopularPerson(int page) async {
    Uri uri;
    uri = Uri.https(_url, _url_prefix + '/person/popular', {
      'page': page.toString(),
      'api_key': _url_api_key,
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
