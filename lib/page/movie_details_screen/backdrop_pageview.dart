import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/model/ui/SimpleBanner.dart';
import 'package:the_movies_flut/widget/page_indicators/page_view_indicator.dart';

class BackdropPageView extends StatelessWidget {
  final SimpleBanners banners;

  BackdropPageView({Key key, @required this.banners}) : super(key: key);

  int getSize() {
    return banners != null ? banners.banners.length : 0;
  }

  final pageIndexNotifier = ValueNotifier<int>(0);
  static final radiusPoster = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (index) => pageIndexNotifier.value = index,
            children:
                banners.banners.map((item) => getItemsWidget(item)).toList(),
          ),
          Align(
            alignment: Alignment(-1, 1),
            child: Padding(
              padding: EdgeInsets.only(
                  left: radiusPoster * 2 + 10 + 20, bottom: 3.0),
              child: PageViewIndicator(
                alignment: MainAxisAlignment.start,
                pageIndexNotifier: pageIndexNotifier,
                length: getSize(),
                indicatorPadding: EdgeInsets.all(1.0),
                normalBuilder: (animationController, index) => Circle(
                      size: 6.0,
                      color: Colors.white70,
                    ),
                highlightedBuilder: (animationController, index) =>
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animationController,
                        curve: Curves.ease,
                      ),
                      child: Circle(
                        size: 8.0,
                        color: Colors.white70,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getItemsWidget(SimpleBanner item) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          alignment: AlignmentDirectional(0, 0),
          child: Image.network(
            item.image,
            fit: BoxFit.fill,
          ),
        ),
        Center(
            child: FloatingActionButton(
          child: Icon(
            Icons.play_arrow,
            size: 56,
          ),
          backgroundColor: Colors.black38,
          onPressed: () => {},
        )),
      ],
    );
  }
}
