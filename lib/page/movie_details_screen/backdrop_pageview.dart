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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (index) => pageIndexNotifier.value = index,
            children:
                banners.banners.map((item) => getItemsWidget(item)).toList(),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: PageViewIndicator(
                pageIndexNotifier: pageIndexNotifier,
                length: getSize(),
                indicatorPadding: EdgeInsets.all(2.0),
                normalBuilder: (animationController, index) => Circle(
                      size: 8.0,
                      color: Colors.white70,
                    ),
                highlightedBuilder: (animationController, index) =>
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animationController,
                        curve: Curves.ease,
                      ),
                      child: Circle(
                        size: 12.0,
                        color: Colors.white70,
                      ),
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getItemsWidget(SimpleBanner item) {
    return Stack(
      children: <Widget>[
        Center(
          child: Image.network(
            item.image,
            fit: BoxFit.cover,
          ),
        ),
        Center(
            child: Text(
          item.image,
          style: TextStyle(color: Colors.white),
        )),
      ],
    );
  }
}
