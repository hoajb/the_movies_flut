import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';

abstract class MovieListState {}

class UnMovieListState extends MovieListState {
  @override
  String toString() {
    return "UnMovieListState";
  }
}

class InMovieListState extends MovieListState {
  final List<SimpleMovieItem> lists;
  final int currentPage;

  InMovieListState(this.lists, this.currentPage);

  get hasReachedMax => false;

  @override
  String toString() {
    return "InMovieListState[page:$currentPage][listSize: ${lists.length ?? 0}]";
  }
}

class ErrorMovieListState extends MovieListState {
  final String error;

  ErrorMovieListState(this.error);

  @override
  String toString() {
    return this.error ?? "MovieListState";
  }
}
