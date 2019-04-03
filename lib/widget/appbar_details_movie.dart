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

  static final heightTitle = 100.0;
  static final height = 450.0;
  static final radiusPoster = 60.0;
  static final sizeCirclePadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      pinned: true,
      title: TitleAppBarOpacityWidget(
        title: simpleData.title,
        opacity: opacity,
      ),
      expandedHeight: height,
      flexibleSpace: MyFlexibleSpaceBar(
        centerTitle: false,
        opacityNotifier: opacity,
        title: TitleMovie(simpleData: simpleData),
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
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: <Widget>[
                      Stack(
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
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 60, right: 10),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                                child: RaisedButton(
                                  color: Colors.transparent,
                                  highlightColor:
                                      AppColors.colorThemePrimary[100],
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white70,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.5,
                                          color: Colors.white70),
                                      borderRadius: BorderRadiusDirectional.all(
                                          Radius.circular(20.0))),
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white70,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.bookmark_border,
                                  color: Colors.white70,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.playlist_add,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          color: Colors.transparent,
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

class TitleMovie extends StatelessWidget {
  static final heightTitle = 100.0;
  final SimpleMovieItem simpleData;

  const TitleMovie({Key key, this.simpleData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: heightTitle,
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "2019",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "60m",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                padding: const EdgeInsets.only(
                    top: 1.0, bottom: 1.0, left: 5, right: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0, color: AppColors.colorThemePrimary[400]),
                  borderRadius: BorderRadius.all(Radius.circular(
                          10.0) //                 <--- border radius here
                      ),
                ),
                child: Text(
                  "Returning Series",
                  style: TextStyle(
                      color: AppColors.colorThemePrimary[400], fontSize: 12),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            simpleData.title,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "Action & Adventure, Sci-Fi & Fantasy",
            style: TextStyle(
                color: AppColors.colorThemePrimary[400], fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class TitleAppBarOpacityWidget extends StatefulWidget {
  final String title;
  final ValueNotifier<double> opacity;

  const TitleAppBarOpacityWidget({Key key, this.title, this.opacity})
      : super(key: key);

  @override
  _TitleAppBarOpacityWidgetState createState() =>
      _TitleAppBarOpacityWidgetState();
}

class _TitleAppBarOpacityWidgetState extends State<TitleAppBarOpacityWidget> {
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
