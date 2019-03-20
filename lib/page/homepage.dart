import 'package:flutter/material.dart';
import 'package:the_movies_flut/page/rowlistmovies.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RowMovies(title: "Popular"),
          RowMovies(title: "Popular"),
          RowMovies(title: "Popular"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class RowMovies extends StatelessWidget {
  final String title;
  final Color colorText = Colors.white70;

  const RowMovies({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(64, 75, 96, 0.8),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.view_list,
                    color: colorText,
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            title,
                            style: TextStyle(color: colorText),
                          ))),
                  Icon(
                    Icons.menu,
                    color: colorText,
                  ),
                ],
              ),
              Expanded(child: RowListMovies()),
            ],
          ),
        ),
      ),
    );
  }
}
