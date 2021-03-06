import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/page/popularpeople.dart';
import 'package:the_movies_flut/page/rowlistmovies.dart';
import 'package:the_movies_flut/resource/app_resources.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    _count += 10;
    return Container(
      color: AppColors.colorThemePrimary,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              _count.toString(),
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            RowMovies(
              title: "Popular",
              iconData: Icons.featured_play_list,
              listType: ApiMovieListType.Popularity,
            ),
            RowMovies(
              title: "Now Playing",
              iconData: Icons.movie,
              listType: ApiMovieListType.Playing,
            ),
            RowMovies(
              title: "On TV",
              iconData: Icons.live_tv,
              listType: ApiMovieListType.Ontv,
            ),
            RowPeople(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class RowMovies extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color colorText = Colors.white70;
  final ApiMovieListType listType;

  const RowMovies({Key key, this.title, this.iconData, this.listType})
      : super(key: key);

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
              Expanded(
                  child: RowListMovies(
                key: PageStorageKey<String>(title + "key"),
                listType: listType,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class RowPeople extends StatelessWidget {
  final Color colorText = Colors.white70;

  const RowPeople({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
                    Icons.people,
                    color: colorText,
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            "Popular People",
                            style: TextStyle(color: colorText),
                          ))),
                  Icon(
                    Icons.more_vert,
                    color: colorText,
                  ),
                ],
              ),
              Expanded(
                child: PopularPeopleRowList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
