import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {}

class FetchEvent extends MoviesEvent {
  @override
  String toString() => 'Fetch';
}

class ShowMovieDetailEvent extends MoviesEvent {
  final String movieName;

  ShowMovieDetailEvent(this.movieName);

  @override
  String toString() => 'ShowMovieDetail';
}
