import 'package:flutter/material.dart';
import 'package:the_movies_flut/page/movielist/bloc_export.dart';
import 'package:the_movies_flut/util/alog.dart';
import 'package:the_movies_flut/widget/movie_widget.dart';

class MovieListPage2 extends StatefulWidget {
  @override
  _MovieListPage2State createState() => _MovieListPage2State();
}

class _MovieListPage2State extends State<MovieListPage2> {
  final MovieListBloc _bloc = MovieListBloc();

  @override
  void initState() {
    _bloc.dispatchEvent(LoadMovieListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        initialData: UnMovieListState(),
        stream: _bloc.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var state = snapshot.data;
          if (state is UnMovieListState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorMovieListState) {
            return Center(
              child: Text(state.toString()),
            );
          }

          if (state is InMovieListState) {
            if (state.lists.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return Container(
              height: 300,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Alog.debug("ListView index :" +
                      index.toString() +
                      "/" +
                      state.lists.length.toString());
                  if (state.lists.length > 0 &&
                      index == state.lists.length - 2) {
                    Alog.debug("ListView -- loadmore: " +
                        state.lists.length.toString());
                    _bloc.dispatchEvent(LoadMoreMovieListEvent());
                  }
                  return index >= state.lists.length
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : MovieWidget(data: state.lists[index]);
                },
                scrollDirection: Axis.horizontal,
                itemCount: state.hasReachedMax
                    ? state.lists.length
                    : state.lists.length + 1,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
