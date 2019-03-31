import 'dart:async';

import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/repository.dart';
import 'package:the_movies_flut/page/movielist/bloc_export.dart';
import 'package:the_movies_flut/util/alog.dart';

class MovieListBloc {
  MovieListState _lastState;
  final ApiMovieListType listType = ApiMovieListType.Popularity;

  //state
  final _stateController = StreamController<MovieListState>.broadcast();

  StreamSink<MovieListState> get _inStreamSink => _stateController.sink;

  Stream<MovieListState> get stream => _stateController.stream;

  //event
  final _eventController = StreamController<MovieLisEvent>();

  Sink<MovieLisEvent> get _movieListEvent => _eventController.sink;

  MovieListBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispatchEvent(MovieLisEvent event) {
    _movieListEvent.add(event);
  }

  void _mapEventToState(MovieLisEvent event) async {
    MovieListState prepareState;
    if (event is LoadMovieListEvent) {
      //load init
      final posts = await Repository.getMovieListByType(listType, 1);

      prepareState = InMovieListState(posts, 1);
    } else if (event is LoadMoreMovieListEvent) {
//      MovieListState currentState = await stream.last;
      MovieListState currentState = _lastState;
      if (currentState is InMovieListState) {
        var nextPage = currentState.currentPage + 1;
        final posts = await Repository.getMovieListByType(listType, nextPage);
        currentState.lists.addAll(posts);
        prepareState = InMovieListState(currentState.lists, nextPage);
      } else {
        //load init
        final posts = await Repository.getMovieListByType(listType, 1);

        prepareState = InMovieListState(posts, 1);
      }
    } else {
      prepareState = ErrorMovieListState("Undefined");
    }
    _lastState = prepareState;
    _inStreamSink.add(prepareState);
  }

  void dispose() {
    _lastState = null;
    _stateController.close();
    _eventController.close();
  }
}
