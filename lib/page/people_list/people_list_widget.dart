import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies_flut/api/filter/APIFilter.dart';
import 'package:the_movies_flut/resource/app_resources.dart';
import 'package:the_movies_flut/util/alog.dart';

import 'people_list_export.dart';

class PeopleListWidget extends StatefulWidget {
  final ApiMovieListType listType;

  PeopleListWidget({Key key, this.listType}) : super(key: key);

  @override
  _PeopleListWidgetState createState() => _PeopleListWidgetState();
}

class _PeopleListWidgetState extends State<PeopleListWidget> {
  PeopleBloc _bloc;

  @override
  void initState() {
    if (_bloc != null) {
      _bloc.dispose();
    }
    _bloc = PeopleBloc();
    _bloc.dispatch(FetchInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: BlocBuilder<PeopleRowListEvent, PeopleListState>(
        bloc: _bloc,
        builder: (BuildContext context, PeopleListState state) {
          if (state is UninitializedPeopleListState ||
              state is FetchingPeopleListState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorPeopleListState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    state.toString(),
                    style: TextStyle(
                        color: Colors.white70, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RawMaterialButton(
                    fillColor: AppColors.colorThemeAccent[400],
                    highlightColor: AppColors.colorThemeAccent[300],
                    onPressed: () {
                      _bloc.dispatch(FetchInitEvent());
                    },
                    child: Text(
                      "Retry",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is FetchedPeopleListState) {
            if (state.lists.isEmpty) {
              return Center(
                child: Text('No Data'),
              );
            }
            return Container(
              height: 300,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (state.lists.length > 0 &&
                      index == state.lists.length - 2) {
                    _bloc.dispatch(FetchMoreEvent());
                    Alog.debug("PeopleList FetchMoreEvent[index $index]");
                  }

                  Alog.debug(
                      "PeopleList [index $index] [size ${state.lists.length}]");

                  return index >= state.lists.length
                      ? SizedBox(
                          width: 45,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              Text(
                                "\n",
                              )
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                minRadius: 40.0,
                                backgroundImage:
                                    NetworkImage(state.lists[index].image),
                                backgroundColor: Colors.transparent,
                              ),
                              Text(
                                state.lists[index].name.replaceAll(" ", '\n'),
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
                },
                scrollDirection: Axis.horizontal,
                itemCount: state.hasLoadMore
                    ? state.lists.length + 1
                    : state.lists.length,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
