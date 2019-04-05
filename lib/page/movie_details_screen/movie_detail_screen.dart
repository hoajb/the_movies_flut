import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/model/ui/SimpleBanner.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/page/movie_details_screen/activities_page.dart';
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
    return _myWidget2();
  }

  SimpleBanners getBanners() {
    var bannerList = List<SimpleBanner>();
    for (var i = 0; i < 5; i++) {
      bannerList
          .add(SimpleBanner("https://images5.alphacoders.com/545/545768.jpg"));
    }
    return SimpleBanners(_simpleData.id, bannerList);
  }

  Widget _myWidget2() {
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

  Widget _myWidget() {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          AppBarDetailsMovie(
            simpleData: _simpleData,
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              TabBar(
                labelColor: AppColors.colorThemeAccent,
                indicatorColor: AppColors.colorThemeAccent,
                indicatorWeight: 3.0,
                unselectedLabelColor: Colors.white70,
                controller: TabController(
                    length: listTabInfo.length, vsync: ScrollableState()),
                isScrollable: true,
                tabs: listTabInfo.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1500,
              child: PageView(
                children: listTabInfo
                    .map((item) => Center(
                          child: ListView.builder(
                            itemCount: 100,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  height: 30,
                                  child: Text("Tab [$item] [i=$index]"));
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
//          SliverGrid(
//            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//              maxCrossAxisExtent: 300.0,
//              mainAxisSpacing: 10.0,
//              crossAxisSpacing: 10.0,
//              childAspectRatio: 4.0,
//            ),
//            delegate: SliverChildBuilderDelegate(
//              (BuildContext context, int index) {
//                return Container(
//                  alignment: Alignment.center,
//                  color: Colors.teal[100 * (index % 9)],
//                  child: Text('grid item $index'),
//                );
//              },
//              childCount: 80,
//            ),
//          ),
        ],
      ),
    );
  }

  Widget _baoWidget() {
    return ActivitiesPage();
  }
}

class MyPreferredSizeWidget extends StatelessWidget with PreferredSizeWidget {
  final Widget child;

  MyPreferredSizeWidget({Key key, this.child}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return child;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: AppColors.colorThemePrimary,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _SliverTitleMovieDelegate extends SliverPersistentHeaderDelegate {
  _SliverTitleMovieDelegate(this.child);

  final Widget child;

  @override
  double get minExtent => 100;

  @override
  double get maxExtent => 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
