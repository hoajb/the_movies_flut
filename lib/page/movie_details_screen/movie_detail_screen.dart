import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/widget/appbar_details_movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  final SimpleMovieItem simpleData;

  const MovieDetailsScreen({Key key, @required this.simpleData})
      : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  SimpleMovieItem _simpleData;

  @override
  void initState() {
    _simpleData = widget.simpleData;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          AppBarDetailsMovie(
            simpleData: _simpleData,
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 80,
            ),
          ),
        ],
      ),
    );
  }
}
