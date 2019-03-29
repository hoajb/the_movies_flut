import 'package:equatable/equatable.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';

abstract class ListState extends Equatable {
  ListState([List props = const []]) : super(props);
}

class ErrorListState extends ListState {
  final String error;

  ErrorListState(this.error);

  @override
  String toString() => this.error ?? 'ListError';
}

class FetchingListState extends ListState {
  @override
  String toString() => 'FetchingListState';
}

class UninitializedListState extends ListState {
  @override
  String toString() => 'UninitializedListState';
}

class FetchedListState extends ListState {
  final List<SimpleMovieItem> lists;
  final bool hasLoadMore;
  final int currentPage;

  FetchedListState({
    this.lists,
    this.currentPage,
    this.hasLoadMore,
  }) : super([lists, currentPage, hasLoadMore]);

  FetchedListState copyWith({
    List<SimpleMovieItem> lists,
    int currentPage,
    bool hasLoadMore,
  }) {
    return FetchedListState(
      lists: lists ?? this.lists,
      currentPage: currentPage ?? this.currentPage,
      hasLoadMore: hasLoadMore ?? this.hasLoadMore,
    );
  }

  @override
  String toString() =>
      'FetchedListState { Lists: ${lists.length}, currentPage: $currentPage, hasLoadMore: $hasLoadMore }';
}
