import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'homepage.dart';
import 'progresspage.dart';
import 'trailerspage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Movies"),
      ),
      body: PageView(
        children: [
          HomePage(),
          TrailersPage(),
          ProgressPage(),
        ],
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavigationBarTap,
          fixedColor: Colors.orange,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                backgroundColor: Colors.white10,
                title: Text(
                  "Home",
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.playlist_play),
                backgroundColor: Colors.white10,
                title: Text("Trailers")),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                backgroundColor: Colors.white10,
                title: Text("Progress")),
          ]),
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
    _pageController.jumpToPage(page);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
