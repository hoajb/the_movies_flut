import 'package:flutter/material.dart';
import 'package:the_movies_flut/page/rowlistmovies.dart';
import 'package:the_movies_flut/resource/app_resources.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorThemePrimary,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RowMovies(title: "Popular", iconData: Icons.featured_play_list ),
            RowMovies(title: "Now Playing", iconData: Icons.movie),
            RowMovies(title: "On TV", iconData: Icons.live_tv),
          ],
        ),
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
  final IconData iconData;
  final Color colorText = Colors.white70;

  const RowMovies({Key key, this.title, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: AppColors.colorThemePrimary[800],
              border: null,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    iconData,
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
                    Icons.more_vert,
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
