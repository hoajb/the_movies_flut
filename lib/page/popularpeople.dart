import 'package:flutter/material.dart';
import 'package:the_movies_flut/api/model/ui/SimplePeople.dart';
import 'package:the_movies_flut/api/repository.dart';
import 'package:the_movies_flut/util/alog.dart';
import 'package:the_movies_flut/widget/color_loader_4.dart';

class PopularPeopleRowList extends StatefulWidget {
  const PopularPeopleRowList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PopularPeopleRowListState();
  }
}

class _PopularPeopleRowListState extends State<PopularPeopleRowList> {
  _PopularPeopleRowListState({Key key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SimplePeople>>(
      future: Repository.getPopularPeople(1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return ColorLoader4();
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return PeopleList(listData: snapshot.data);
        }
        return null; // unreachable
      },
    );
  }
}

class PeopleList extends StatefulWidget {
  final List<SimplePeople> listData;

  const PeopleList({Key key, this.listData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PeopleListState();
  }
}

class _PeopleListState extends State<PeopleList> {
  List<SimplePeople> _listData;
  var _page;
  bool isLoading;

  @override
  void initState() {
    _page = 1;
    _listData = widget.listData != null ? widget.listData : List();
    isLoading = false;
    super.initState();
  }

  _fetchData(int page) async {
    isLoading = true;
    var postList = await Repository.getPopularPeople(page);
    if (postList == null) {
//      _error = "Error API";
    } else {
      isLoading = false;
      if (mounted) {
        setState(() {
          _listData.addAll(postList);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listData.length, //> 0 ? _listData.length + 1 : 0,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (!isLoading &&
              _listData.length > 0 &&
              index == _listData.length - 3) {
            _fetchData(++_page);
          }

          if (_listData.length > 0 && index == _listData.length - 1) {
            return Container(
                width: 45, child: Center(child: CircularProgressIndicator()));
          }
          return Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  minRadius: 40.0,
                  backgroundImage: NetworkImage(_listData[index].image),
                  backgroundColor: Colors.transparent,
                ),
                Text(
                  _listData[index].name.replaceAll(" ", '\n'),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          );
        });
  }
}
