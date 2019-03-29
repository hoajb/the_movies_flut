import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies_flut/api/model/ui/SimpleMovieItem.dart';
import 'package:the_movies_flut/bloc/bloc.dart';

class MovieWidgetProvider extends StatelessWidget {
  final SimpleMovieItem data;

  const MovieWidgetProvider({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MoviesBloc bloc = BlocProvider.of<MoviesBloc>(context);

    return GestureDetector(
      onTap: () => bloc.dispatch(ShowMovieDetailEvent(data.title)),
      child: Container(
        width: 130,
        padding: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Image.network(
                data.image,
              ),
            ),
            Text(
              data.title + "\n",
              textAlign: TextAlign.left,
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
      ),
    );
  }
}
