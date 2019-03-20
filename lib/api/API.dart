import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

import 'package:the_movies_flut/api/model/MovieData.dart';

class API {
  static final HttpClient _httpClient = HttpClient();
  static final String _url_seedin = "qa.newunionplayground.com";
  static final String _url = "api.themoviedb.org";
  static final String _url_prefix = "/3";
  static final String _url_api_key = "1f5b86b5d2ec241ec5863bc7941fad12";
  static String get UrlBaseImage => "https://image.tmdb.org/t/p/w500";



  static Future<List<MovieData>> getTheMovieList(int page) async {
    final uri = Uri.https(_url, _url_prefix + '/movie/now_playing',
        {'page': page.toString(), 'api_key': _url_api_key});

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
//    if (jsonResponse['errors'] != null) {
//      return null;
//    }
//    if (jsonResponse['items'] == null) {
//      return List();
//    }

    return MovieList.fromJson(jsonResponse).results;
  }

  static Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      print(uri);
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
}
