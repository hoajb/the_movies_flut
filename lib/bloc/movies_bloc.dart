import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/api/repository.dart';
import 'package:the_movies_flut/bloc/listdatastate.dart';
import 'package:the_movies_flut/bloc/movies_event.dart';
import 'package:the_movies_flut/util/alog.dart';

class MoviesBloc extends Bloc<MoviesEvent, ListDataState> {
  final ApiMovieListType listType;

  MoviesBloc(this.listType);

  @override
  ListDataState get initialState => ListUninitialized();

  @override
  Stream<ListDataState> mapEventToState(MoviesEvent event) async* {
    Alog.debug("mapEventToState : $event");

    if (event is FetchEvent) {
      if (!_hasReachedMax(currentState)) {
        try {
          //init load
          if (currentState is ListUninitialized) {
            final posts = await Repository.getMovieListByType(listType, 1);

            yield ListLoaded(
                lists: posts, currentPage: 1, hasReachedMax: false);
            return;
          }

          //load more
          if (currentState is ListLoaded) {
            var currentListState = (currentState as ListLoaded);
            var nextPage = currentListState.currentPage + 1;
            final posts =
                await Repository.getMovieListByType(listType, nextPage);

            var length = posts.length;
            Alog.debug("getMovieListByType : $nextPage - size : $length");

            if (posts.isEmpty) {
              Alog.debug("ListLoaded :posts.isEmpty - hasReachedMax : true");
              yield ListLoaded(
                  lists: currentListState.lists,
                  hasReachedMax: true,
                  currentPage: 0);
              return;
            } else {
              yield ListLoaded(
                  lists: _appendList(currentListState.lists, posts),
                  hasReachedMax: false,
                  currentPage: nextPage);
              return;
            }
          }
        } catch (e) {
          yield ListError(e.toString());
        }
      }
    } else if (event is ShowMovieDetailEvent) {

      yield ShowDetailState(event.movieName);
      return;
    }
  }

  List<SimpleMovieItem> _appendList(
      List<SimpleMovieItem> current, List<SimpleMovieItem> append) {
    current.addAll(append);

    return current;
  }

  bool _hasReachedMax(ListDataState state) =>
      state is ListLoaded && state.hasReachedMax;

  @override
  Stream<MoviesEvent> transform(Stream<MoviesEvent> events) {
    return (events as Observable<MoviesEvent>)
        .debounce(Duration(milliseconds: 500));
  }
}
