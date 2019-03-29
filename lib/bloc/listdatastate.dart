import 'package:equatable/equatable.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';

abstract class ListDataState extends Equatable {
  ListDataState([List props = const []]) : super(props);
}

class ListUninitialized extends ListDataState {
  @override
  String toString() => 'ListUninitialized';
}

class ListError extends ListDataState {
  final String error;

  ListError(this.error);

  @override
  String toString() => this.error ?? 'ListError';
}

class ListLoaded extends ListDataState {
  final List<SimpleMovieItem> lists;
  final bool hasReachedMax;
  final int currentPage;

  ListLoaded({
    this.lists,
    this.currentPage,
    this.hasReachedMax,
  }) : super([lists, currentPage, hasReachedMax]);

  ListLoaded copyWith({
    List<SimpleMovieItem> lists,
    int currentPage,
    bool hasReachedMax,
  }) {
    return ListLoaded(
      lists: lists ?? this.lists,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  ListLoaded appendList({
    List<SimpleMovieItem> lists,
    int currentPage,
    bool hasReachedMax,
  }) {
    return ListLoaded(
      lists: lists ?? this.lists,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'ListLoaded { Lists: ${lists.length}, hasReachedMax: $hasReachedMax }';
}
