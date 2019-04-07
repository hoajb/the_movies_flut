import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/model/ui/SimpleBanner.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/resource/app_resources.dart';
import 'package:the_movies_flut/widget/appbar_details_movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  final SimpleMovieItem simpleData;

  const MovieDetailsScreen({Key key, @required this.simpleData})
      : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with TickerProviderStateMixin {
  SimpleMovieItem _simpleData;
  final List<String> listTabInfo = List<String>();
  TabController _controller;

  @override
  void initState() {
    _simpleData = widget.simpleData;
    listTabInfo.add("Info");
    listTabInfo.add("Cast");
    listTabInfo.add("Seasons");
    listTabInfo.add("Guild");
    listTabInfo.add("Comments");
    listTabInfo.add("Related");
    listTabInfo.add("Similar");
    _controller = TabController(length: listTabInfo.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            AppBarDetailsMovie(
              simpleData: _simpleData,
              tabBar: TabBar(
                labelColor: AppColors.colorThemeAccent,
                indicatorColor: AppColors.colorThemeAccent,
                indicatorWeight: 3.0,
                unselectedLabelColor: Colors.white70,
                controller: _controller,
                isScrollable: true,
                tabs: listTabInfo.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: listTabInfo
              .map((item) => Center(
                    child: ListView.builder(
                      itemCount: 100,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 30, child: Text("Tab [$item] [i=$index]"));
                      },
                    ),
                  ))
              .toList(),
          controller: _controller,
        ),
      ),
    );
  }

  SimpleBanners getBanners() {
    var bannerList = List<SimpleBanner>();
    for (var i = 0; i < 5; i++) {
      bannerList
          .add(SimpleBanner("https://images5.alphacoders.com/545/545768.jpg"));
    }
    return SimpleBanners(_simpleData.id, bannerList);
  }
}
