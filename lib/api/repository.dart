import 'package:the_movies_flut/api/API.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/model/MovieData.dart';
import 'package:the_movies_flut/api/model/Person.dart';
import 'package:the_movies_flut/api/model/TVShow.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/api/model/ui/SimplePeople.dart';
import 'package:the_movies_flut/util/alog.dart';

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

  static Future<DataListResult<List<SimpleMovieItem>>> getMovieListByType2(
      ApiMovieListType type, int page) {
    if (type == ApiMovieListType.Ontv) {
      Future<DataListResult<List<TVShowData>>> movieListByType =
          API.getTVShowListByType2(type, page);

      return movieListByType
          .then<DataListResult<List<SimpleMovieItem>>>((list) {
        return DataListResult<List<SimpleMovieItem>>(
            totalItems: list.totalItems,
            totalPages: list.totalPages,
            data: list.data
                .map((movie) => SimpleMovieItem.fromTVShow(movie))
                .toList(),
            error: ErrorResult(""));
      });
    } else {
      Future<DataListResult<List<MovieData>>> movieListByType =
          API.getMovieListByType2(type, page);

      return movieListByType
          .then<DataListResult<List<SimpleMovieItem>>>((list) {
        return DataListResult<List<SimpleMovieItem>>(
            totalItems: list.totalItems,
            totalPages: list.totalPages,
            data: list.data
                .map((movie) => SimpleMovieItem.fromMovie(movie))
                .toList(),
            error: ErrorResult(""));
      });
    }
  }

  static Future<DataListResult<List<SimplePeople>>> getPeoplePopularList(
      int page) {
    var popularPerson = API.getPopularPerson2(page);
    Alog.debug("getPopularPerson2 [$popularPerson]");
    return popularPerson
        .then<DataListResult<List<SimplePeople>>>((resultsList) {
      Alog.debug("getPopularPerson2 body [$resultsList]");
      return DataListResult<List<SimplePeople>>(
          totalItems: resultsList.totalItems,
          totalPages: resultsList.totalPages,
          data: resultsList.data
              .map((item) => SimplePeople.fromPerson(item))
              .toList(),
          error: ErrorResult(""));
    });
  }
}

class DataResult<T> {
  final T data;
  final ErrorResult error;

  DataResult({this.data, this.error});
}

class DataListResult<T> {
  final T data;
  final ErrorResult error;

  final int totalPages;
  final int totalItems;

  DataListResult({this.totalPages, this.totalItems, this.data, this.error});

  @override
  String toString() {
    return "DataListResult[data=${(data as List).length} , error=$error, totalPages=$totalPages, totalItems=$totalItems]";
  }
}

class ErrorResult {
  final String error;

  ErrorResult(this.error);

  bool isError() {
    return error != null && error != "";
  }

  static ErrorResult init() {
    return ErrorResult("");
  }
}
