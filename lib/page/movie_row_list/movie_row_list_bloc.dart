import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/repository.dart';
import 'package:the_movies_flut/page/movie_row_list/movie_row_list_export.dart';
import 'package:the_movies_flut/util/alog.dart';

class MoviesBloc extends Bloc<MovieRowListEvent, ListState> {
  final ApiMovieListType listType;

  MoviesBloc(this.listType);

  @override
  ListState get initialState => UninitializedListState();

  @override
  Stream<ListState> mapEventToState(MovieRowListEvent event) async* {
    Alog.debug("mapEventToState : $event");

    try {
      if (event is FetchInitEvent) {
        final posts = await Repository.getMovieListByType(listType, 1);

        yield FetchedListState(lists: posts, currentPage: 1, hasLoadMore: true);
        return;
      } else if (event is FetchMoreEvent) {
        if (currentState is FetchedListState) {
          var fetchedState = currentState as FetchedListState;
          if (fetchedState.hasLoadMore) {
            var nextState = fetchedState.currentPage + 1;
            final posts =
                await Repository.getMovieListByType(listType, nextState);
            fetchedState.lists.addAll(posts);
            yield FetchedListState(
                lists: fetchedState.lists,
                currentPage: nextState,
                hasLoadMore: true);
            return;
          }

          yield FetchedListState(
              lists: fetchedState.lists,
              currentPage: fetchedState.currentPage,
              hasLoadMore: false);
          return;
        }
      }
    } catch (_) {
      yield ErrorListState(_);
      return;
    }
  }

  @override
  Stream<MovieRowListEvent> transform(Stream<MovieRowListEvent> events) {
    return (events as Observable<MovieRowListEvent>)
        .debounce(Duration(milliseconds: 500));
  }
}
