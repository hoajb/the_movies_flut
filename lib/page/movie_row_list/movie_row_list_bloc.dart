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
    try {
      if (event is FetchInitEvent) {
        var initPage = 1;
        final posts = await Repository.getMovieListByType2(listType, initPage);

        if (posts.error.isError()) {
          yield ErrorListState(posts.error.error);
          return;
        } else {
          yield FetchedListState(
              lists: posts.data,
              currentPage: initPage,
              hasLoadMore: initPage < posts.totalPages);
          return;
        }
      } else if (event is FetchMoreEvent) {
        if (currentState is FetchedListState) {
          var fetchedState = currentState as FetchedListState;
          
          if (fetchedState.hasLoadMore) {
            var nextPage = fetchedState.currentPage + 1;
            final posts =
                await Repository.getMovieListByType2(listType, nextPage);
            fetchedState.lists.addAll(posts.data);

            yield FetchedListState(
                lists: fetchedState.lists,
                currentPage: nextPage,
                hasLoadMore: nextPage < posts.totalPages);
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
      yield ErrorListState(_.toString());
      return;
    }
  }

  @override
  void onTransition(Transition<MovieRowListEvent, ListState> transition) {
    Alog.debug("People[$transition]");
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    Alog.debug("MoviesBlocError[$error]");
    Alog.debug("MoviesBlocError------------------------------");
    Alog.debug("MoviesBlocError[$stacktrace]");
    super.onError(error, stacktrace);
  }

  @override
  Stream<MovieRowListEvent> transform(Stream<MovieRowListEvent> events) {
    return (events as Observable<MovieRowListEvent>)
        .debounce(Duration(milliseconds: 200));
  }
}
