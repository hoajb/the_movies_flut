import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_movies_flut/page/homepage.dart';
import 'package:the_movies_flut/page/progresspage.dart';
import 'package:the_movies_flut/page/trailerspage.dart';
import 'package:the_movies_flut/resource/app_resources.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
//  PageController _pageController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
//    _pageController = new PageController();
    _tabController = new TabController(length: 3, vsync: this);

//    _tabController.addListener(() {
//      _onPageChanged(_tabController.index);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Movies"),
      ),
//      body: PageView(
//        children: [
//          HomePage(key: ValueKey("HomePage"),),
//          TrailersPage(),
//          ProgressPage(),
//        ],
//        controller: _pageController,
//        onPageChanged: _onPageChanged,
//      ),

      body: TabBarView(
        children: <Widget>[
          HomePage(
//            key: PageStorageKey<String>("HomePage"),
          ),
          TrailersPage(
//            key: PageStorageKey<String>("TrailersPage"),
          ),
          ProgressPage(
//            key: PageStorageKey<String>("ProgressPage"),
          ),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: Theme(
        child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onBottomNavigationBarTap,
            fixedColor: AppColors.colorThemeAccent,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  backgroundColor: AppColors.colorThemePrimary[700],
                  title: Text(
                    "Home",
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_play),
                  backgroundColor: AppColors.colorThemePrimary[700],
                  title: Text("Trailers")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  backgroundColor: AppColors.colorThemePrimary[700],
                  title: Text("Progress")),
            ]),
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: AppColors.colorThemePrimary[700],
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.white70))),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                _onBottomNavigationBarTap(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Trailers'),
              onTap: () {
                _onBottomNavigationBarTap(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Progress'),
              onTap: () {
                _onBottomNavigationBarTap(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onBottomNavigationBarTap(int page) {
//    _pageController.animateToPage(page,
//        duration: const Duration(milliseconds: 300), curve: Curves.elasticIn);

//    _pageController.jumpToPage(page);
    _tabController.index = page;

    setState(() {
      _selectedIndex = page;
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
//    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
