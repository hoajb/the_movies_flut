import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:the_movies_flut/api/model/ui/SimpleBanner.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/page/movie_details_screen/backdrop_pageview.dart';
import 'package:the_movies_flut/resource/app_resources.dart';
import 'package:the_movies_flut/widget/my_flexible_space_bar.dart';

class AppBarDetailsMovie extends StatelessWidget {
  final SimpleMovieItem simpleData;

  final opacity = ValueNotifier<double>(0.0);

  AppBarDetailsMovie({Key key, this.simpleData}) : super(key: key);

  SimpleBanners getBanners() {
    var bannerList = List<SimpleBanner>();
    for (var i = 0; i < 5; i++) {
      bannerList.add(SimpleBanner(simpleData.image));
    }
    return SimpleBanners(simpleData.id, bannerList);
  }

  final heightTitle = 50.0;
  final height = 350.0;
  final radiusPoster = 60.0;
  final sizeCirclePadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      pinned: true,
      title: TitleWidget(
        title: simpleData.title,
        opacity: opacity,
      ),
      expandedHeight: height,
      flexibleSpace: MyFlexibleSpaceBar(
        centerTitle: false,
        opacityNotifier: opacity,
        title: Text(
          simpleData.title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        background: Padding(
          padding: EdgeInsets.only(bottom: heightTitle),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: radiusPoster),
                child: BackdropPageView(
                  banners: getBanners(),
                ),
              ),
              Align(
                alignment: Alignment(-1, 1),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Stack(
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          width: (radiusPoster + sizeCirclePadding) * 2,
                          height: (radiusPoster + sizeCirclePadding) * 2,
                          color: AppColors.colorThemePrimary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(sizeCirclePadding),
                        child: CircleAvatar(
                          radius: radiusPoster,
                          backgroundImage: NetworkImage(simpleData.image),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatefulWidget {
  final String title;
  final ValueNotifier<double> opacity;

  const TitleWidget({Key key, this.title, this.opacity}) : super(key: key);

  @override
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  double op = 0.0;

  @override
  void initState() {
    widget.opacity.addListener(_updateOpacity);
    super.initState();
  }

  _updateOpacity() {
    //https://stackoverflow.com/questions/54846280/calling-setstate-during-build-without-user-interaction
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
          op = widget.opacity.value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: op,
      child: Text(widget.title),
    );
  }

  @override
  void dispose() {
    widget.opacity.removeListener(_updateOpacity);
    super.dispose();
  }
}
