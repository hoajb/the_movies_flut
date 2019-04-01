import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:the_movies_flut/api/model/ui/SimplePeople.dart';

@immutable
abstract class PeopleListState extends Equatable {
  PeopleListState([List props = const []]) : super(props);
}

class ErrorPeopleListState extends PeopleListState {
  final String error;

  ErrorPeopleListState(this.error):super([error]);

  @override
  String toString() => this.error ?? 'ListError';
}

class FetchingPeopleListState extends PeopleListState {
  @override
  String toString() => 'FetchingPeopleListState';
}

class UninitializedPeopleListState extends PeopleListState {
  @override
  String toString() => 'UninitializedPeopleListState';
}

class FetchedPeopleListState extends PeopleListState {
  final List<SimplePeople> lists;
  final bool hasLoadMore;
  final int currentPage;

  FetchedPeopleListState({
    this.lists,
    this.currentPage,
    this.hasLoadMore,
  }) : super([lists, currentPage, hasLoadMore]);

  @override
  String toString() =>
      'FetchedPeopleListState { Lists: ${lists.length}, currentPage: $currentPage, hasLoadMore: $hasLoadMore }';
}
