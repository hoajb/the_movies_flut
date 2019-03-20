import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/API.dart';
import 'package:the_movies_flut/api/model/MovieData.dart';
import 'package:the_movies_flut/widget/color_loader_4.dart';

class MoviePage extends StatefulWidget {
  MoviePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MoviePageState createState() => _MoviePageState();
}

enum MovieLoadMoreStatus { LOADING, STABLE }

class _MoviePageState extends State<MoviePage> {
  MovieLoadMoreStatus loadMoreStatus = MovieLoadMoreStatus.STABLE;

  @override
  Widget build(BuildContext context) {
    return _buildFuture();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildFuture() {
    return FutureBuilder<List<MovieData>>(
      future: _fetchDataFuture(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return ColorLoader4();
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return MovieTile(listData: snapshot.data);
        }
        return null; // unreachable
      },
    );
  }

  Future<List<MovieData>> _fetchDataFuture() async {
    return API.getTheMovieList(1);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MovieTile extends StatefulWidget {
  final List<MovieData> listData;

  MovieTile({Key key, this.listData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MovieTileState();
}

class MovieTileState extends State<MovieTile> {
  List<MovieData> _listData;
  var _page = 1;

  @override
  void initState() {
    _page = 1;
    _listData = widget.listData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: _listData.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(context, index);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 500 / 750,
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
//    print(API.UrlBaseImage + _listData[index].poster_path);
    print("index/length " +
        index.toString() +
        "/" +
        (_listData.length - 1).toString());

    if (_listData.length > 0 && index == _listData.length - 2) {
      _fetchData(++_page);
      print("fetch page = $_page");
    }
    return Stack(
      children: <Widget>[
        Image.network(API.UrlBaseImage + _listData[index].poster_path),
//        Align(
//          alignment: Alignment.center,
//          child: FadeInImage.assetNetwork(
////              placeholder: 'images/tenor.gif',
//              image: API.UrlBaseImage + _listData[index].poster_path),
//
//
//        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Colors.black26,
                Colors.black38,
                Colors.black45,
                Colors.black54,
              ],
            ),
          ),
          child: Text(
            _listData[index].title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          padding: const EdgeInsets.all(10.0),
        )
      ],
    );

//    return Text(listData[index].title);
  }

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
}

//return new CustomScrollView(slivers: <Widget>[
//new SliverGrid(
//gridDelegate: yourGridDelegate,
//delegate: yourBuilderDelegate,
//),
//new SliverToBoxAdapter(
//child: yourFooter,
//),
//]);
