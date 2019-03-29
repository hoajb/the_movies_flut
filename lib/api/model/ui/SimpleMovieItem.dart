import 'package:the_movies_flut/api/API.dart';
import 'package:the_movies_flut/api/model/MovieData.dart';
import 'package:the_movies_flut/api/model/TVShow.dart';
import 'package:the_movies_flut/util/alog.dart';

class SimpleMovieItem {
  final int id;
  final String image;
  final String title;

  SimpleMovieItem({this.id, this.title, this.image});

  factory SimpleMovieItem.fromMovie(MovieData data) {
    Alog.debug("MovieData.posterPath[${data.title}] - [${data.poster_path}]");
    return SimpleMovieItem(
        id: data.id,
        title: data.title,
        image: (data.poster_path != null && data.poster_path.contains(".jpg"))
            ? API.UrlBaseImage + data.poster_path
            : "");
  }

  factory SimpleMovieItem.fromTVShow(TVShowData data) {
    return SimpleMovieItem(
        id: data.id,
        title: data.name,
        image:
        (data.posterPath != null && data.posterPath.contains(".jpg")) ? API.UrlBaseImage + data.posterPath : "");
  }
}
