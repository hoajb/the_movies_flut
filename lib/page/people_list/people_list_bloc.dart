import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movies_flut/api/repository.dart';
import 'package:the_movies_flut/page/people_list/people_list_export.dart';
import 'package:the_movies_flut/util/alog.dart';

class PeopleBloc extends Bloc<PeopleRowListEvent, PeopleListState> {
  PeopleBloc();

  @override
  PeopleListState get initialState => UninitializedPeopleListState();

  @override
  Stream<PeopleListState> mapEventToState(PeopleRowListEvent event) async* {
    try {
      if (event is FetchInitEvent) {
        var initPage = 1;
        final resultsList = await Repository.getPeoplePopularList(initPage);

        if (resultsList.error.isError()) {
          yield ErrorPeopleListState(resultsList.error.error);
          //return;
        } else {
          yield FetchedPeopleListState(
              lists: resultsList.data,
              currentPage: initPage,
              hasLoadMore: initPage < resultsList.totalPages);
          //return;
        }
      } else if (event is FetchMoreEvent) {
        if (currentState is FetchedPeopleListState) {
          var fetchedState = currentState as FetchedPeopleListState;
          if (fetchedState.hasLoadMore) {
            var nextPage = fetchedState.currentPage + 1;
            final resultsList = await Repository.getPeoplePopularList(nextPage);

            fetchedState.lists.addAll(resultsList.data);
            Alog.debug(
                "resultsListLoadmore[${resultsList.hashCode}] [$resultsList]");
            Alog.debug(
                "FetchedPeopleListState [loaded page = $nextPage] [size loaded ${resultsList.data.length}]");

            yield FetchedPeopleListState(
                lists: fetchedState.lists,
                currentPage: nextPage,
                hasLoadMore: nextPage < resultsList.totalPages);
          } else {
            yield FetchedPeopleListState(
                lists: fetchedState.lists,
                currentPage: fetchedState.currentPage,
                hasLoadMore: false);
            //return;
          }
        }
      }
    } catch (_) {
      Alog.debug("ERROR[$_]");
      yield ErrorPeopleListState(_.toString());
      //return;
    }
  }

  @override
  void onTransition(
      Transition<PeopleRowListEvent, PeopleListState> transition) {
    Alog.debug("People[$transition]");
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    Alog.debug("PeopleonError[$error]");
    Alog.debug("PeopleonError------------------------------");
    Alog.debug("PeopleonError[$stacktrace]");
    super.onError(error, stacktrace);
  }

  @override
  Stream<PeopleRowListEvent> transform(Stream<PeopleRowListEvent> events) {
    return (events as Observable<PeopleRowListEvent>)
        .debounce(Duration(milliseconds: 200));
  }
}
