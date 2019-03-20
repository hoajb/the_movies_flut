import 'package:flutter/material.dart';

class CustomToolbar extends StatefulWidget {
  CustomToolbar({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CustomToolbarState createState() => _CustomToolbarState();
}

class _CustomToolbarState extends State<CustomToolbar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 160.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: Center(
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            Positioned(
              top: 80.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}