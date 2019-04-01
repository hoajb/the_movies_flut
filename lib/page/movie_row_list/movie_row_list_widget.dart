import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/page/movie_row_list/movie_row_list_export.dart';
import 'package:the_movies_flut/resource/app_resources.dart';

class MovieRowListWidget extends StatefulWidget {
  final ApiMovieListType listType;

  MovieRowListWidget({Key key, this.listType}) : super(key: key);

  @override
  _MovieRowListWidgetState createState() => _MovieRowListWidgetState();
}

class _MovieRowListWidgetState extends State<MovieRowListWidget> {
  MoviesBloc _moviesBloc;

  @override
  void initState() {
    if (_moviesBloc != null) {
      _moviesBloc.dispose();
    }
    _moviesBloc = MoviesBloc(widget.listType);
    _moviesBloc.dispatch(FetchInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _moviesBloc,
      child: BlocBuilder<MovieRowListEvent, ListState>(
        bloc: _moviesBloc,
        builder: (BuildContext context, ListState state) {
          if (state is UninitializedListState || state is FetchingListState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorListState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  state.toString(),
                  style: TextStyle(
                      color: Colors.white70, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 8.0,
                ),
                RawMaterialButton(
                  fillColor: AppColors.colorThemeAccent[400],
                  highlightColor: AppColors.colorThemeAccent[300],
                  onPressed: () {
                    _moviesBloc.dispatch(FetchInitEvent());
                  },
                  child: Text(
                    "Retry",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            );
          }

          if (state is FetchedListState) {
            if (state.lists.isEmpty) {
              return Center(
                child: Text('No Data'),
              );
            }
            return Container(
              height: 300,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (state.lists.length > 0 &&
                      index == state.lists.length - 2) {
                    _moviesBloc.dispatch(FetchMoreEvent());
                  }

                  return index >= state.lists.length
                      ? SizedBox(
                          width: 70,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              Text(
                                "\n",
                              )
                            ],
                          ),
                        )
                      : MovieCardWidget(data: state.lists[index]);
                },
                scrollDirection: Axis.horizontal,
                itemCount: state.hasLoadMore
                    ? state.lists.length + 1
                    : state.lists.length,
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

class MovieCardWidget extends StatelessWidget {
  final SimpleMovieItem data;

  const MovieCardWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: data.image != null && data.image != ""
                ? Image.network(data.image, fit: BoxFit.cover)
                : Container(
                    color: AppColors.colorThemePrimary[700],
                    child: Center(
                        child: Text(
                      "No Image",
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic),
                    )),
                  ),
          ),
          Container(
            width: 130,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                data.title + "\n",
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
          )
        ],
      ),
    );
  }
}
