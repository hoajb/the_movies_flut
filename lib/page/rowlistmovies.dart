import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/api/repository.dart';
import 'package:the_movies_flut/util/alog.dart';
import 'package:the_movies_flut/widget/color_loader_4.dart';

class RowListMovies extends StatefulWidget {
  final ApiMovieListType listType;

  const RowListMovies({Key key, this.listType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RowListMoviesState(listType: listType);
  }
}

class _RowListMoviesState extends State<RowListMovies> {
  final ApiMovieListType listType;

  _RowListMoviesState({Key key, this.listType});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SimpleMovieItem>>(
      future: Repository.getMovieListByType(listType, 1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return ColorLoader4();
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return MoviesList(
              listData: snapshot.data,
              listType: listType,
            );
        }
        return null; // unreachable
      },
    );
  }
}

class MoviesList extends StatefulWidget {
  final ApiMovieListType listType;
  final List<SimpleMovieItem> listData;

  const MoviesList({Key key, this.listData, this.listType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoviesListState();
  }
}

class _MoviesListState extends State<MoviesList> {
  List<SimpleMovieItem> _listData;
  var _page;

  @override
  void initState() {
    _page = 1;
    _listData = widget.listData != null ? widget.listData : List();
    super.initState();
  }

  _fetchData(int page) async {
    var postList = await Repository.getMovieListByType(widget.listType, page);
    if (postList == null) {
//      _error = "Error API";
    } else {
      if (mounted) {
        setState(() {
          _listData.addAll(postList);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listData.length, //> 0 ? _listData.length + 1 : 0,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (_listData.length > 0 && index == _listData.length - 3) {
            _fetchData(++_page);
          }

          if (_listData.length > 0 && index == _listData.length - 1) {
            return Container(
                width: 65, child: Center(child: CircularProgressIndicator()));
          }
          return Container(
            width: 130,
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    _listData[index].image,
                  ),
                ),
                Text(
                  _listData[index].title + "\n",
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          );
        });
  }
}
