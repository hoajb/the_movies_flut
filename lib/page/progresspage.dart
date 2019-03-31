import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/bloc/listdatastate.dart';
import 'package:the_movies_flut/bloc/movies_bloc.dart';
import 'package:the_movies_flut/bloc/movies_event.dart';
import 'package:the_movies_flut/util/alog.dart';
import 'package:the_movies_flut/widget/movie_widget_provider.dart';

class ProgressPage extends StatefulWidget {
  ProgressPage({Key key}) : super(key: key);

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  MoviesBloc _moviesBloc;

  @override
  void initState() {
    if (_moviesBloc != null) {
      _moviesBloc.dispose();
    }
    _moviesBloc = MoviesBloc(ApiMovieListType.Popularity);
    _moviesBloc.dispatch(FetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _moviesBloc,
      child: BlocBuilder<MoviesEvent, ListDataState>(
        bloc: _moviesBloc,
        builder: (BuildContext context, ListDataState state) {
          if (state is ShowDetailState) {
            return Center(
              child: Text(state.nameMovie),
            );
          }

          if (state is ListUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ListError) {
            return Center(
              child: Text(state.toString()),
            );
          }

          if (state is ListLoaded) {
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
                  if (state.lists.length > 0 &&
                      index == state.lists.length - 2) {
                    _moviesBloc.dispatch(FetchEvent());
                  }
                  return index >= state.lists.length
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : MovieWidgetProvider(data: state.lists[index]);
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
    _moviesBloc.dispose();
    super.dispose();
  }
}
