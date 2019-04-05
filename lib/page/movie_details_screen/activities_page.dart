import 'package:flutter/material.dart';

///
/// Activities page
///
class ActivitiesPage extends StatefulWidget {
  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

///
/// State
///
class _ActivitiesPageState extends State<ActivitiesPage>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 350,
                leading:
                    IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: TopWidget(),
                  collapseMode: CollapseMode.pin,
                ),
                bottom: TabBar(
                  controller: _controller,
                  tabs: <Tab>[
                    new Tab(text: "STATISTICS"),
                    new Tab(text: "HISTORY"),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [_TabItem("Page 1"), _TabItem("Page 2")],
            controller: _controller,
          )),
    );
  }
}

class _TabItem extends StatelessWidget {
  _TabItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        title: Text("$text item $index"),
      );
    });
  }
}

class TopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ClipPath(
              clipper: _Clipper(),
              child: Container(
                child: Image.network(
                  "https://images5.alphacoders.com/545/545768.jpg",
                  fit: BoxFit.fill,
                ),
                constraints: BoxConstraints.expand(height: 250),
              )),
          Positioned(
            left: 0,
            bottom: 64,
            right: 0,
            child: Row(
              children: <Widget>[
                SizedBox(width: 7),
                Container(
                  height: 156,
                  width: 156,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

///
///
///
class _Clipper extends CustomClipper<Path> {
  _Clipper({this.radius = 80});

  final double radius;

  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    path.lineTo(radius * 2 + 5, size.height);
    path.arcToPoint(Offset(5, size.height),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_Clipper oldClipper) {
    return oldClipper.radius != radius;
  }
}
