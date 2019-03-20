import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/API.dart';
import 'package:the_movies_flut/api/model/MovieData.dart';
import 'package:the_movies_flut/widget/color_loader_4.dart';

class RowListMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieData>>(
      future: API.getTheMovieList(1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return ColorLoader4();
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return MoviesList(listData: snapshot.data);
        }
        return null; // unreachable
      },
    );
  }
}

class MoviesList extends StatefulWidget {
  final List<MovieData> listData;

  MoviesList({Key key, this.listData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoviesListState();
  }
}

class _MoviesListState extends State<MoviesList> {
  List<MovieData> _listData;
  var _page;

  @override
  void initState() {
    _page = 1;
    _listData = widget.listData != null ? widget.listData : List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fetchData(int page) async {
      var postList = await API.getTheMovieList(page);
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

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listData.length,
        itemBuilder: (BuildContext context, int index) {
          if (_listData.length > 0 && index == _listData.length - 2) {
            _fetchData(++_page);
            print("fetch page = $_page");
          }
          return Container(
            width: 130,
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    API.UrlBaseImage + _listData[index].poster_path,
                  ),
                ),
                Text(
                  _listData[index].title + "\n",
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                )
              ],
            ),
          );
        });
  }
}
