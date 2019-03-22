import 'package:the_movies_flut/api/API.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/model/MovieData.dart';
import 'package:the_movies_flut/api/model/Person.dart';
import 'package:the_movies_flut/api/model/TVShow.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/api/model/ui/SimplePeople.dart';

class Repository {
  static Future<List<SimpleMovieItem>> getMovieListByType(
      ApiMovieListType type, int page) {
    if (type == ApiMovieListType.Ontv) {
      Future<List<TVShowData>> movieListByType =
          API.getTVShowListByType(type, page);

      return movieListByType.then<List<SimpleMovieItem>>((list) {
        return list.map((show) => SimpleMovieItem.fromTVShow(show)).toList();
      });
    } else {
      Future<List<MovieData>> movieListByType =
          API.getMovieListByType(type, page);

      return movieListByType.then<List<SimpleMovieItem>>((list) {
        return list.map((movie) => SimpleMovieItem.fromMovie(movie)).toList();
      });
    }
  }

  static Future<List<SimplePeople>> getPopularPeople(int page) {
    Future<List<Person>> movieListByType = API.getPopularPerson(page);

    return movieListByType.then<List<SimplePeople>>((list) {
      return list.map((show) => SimplePeople.fromPerson(show)).toList();
    });
  }
}
