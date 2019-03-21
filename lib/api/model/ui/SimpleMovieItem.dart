import 'package:the_movies_flut/api/API.dart';
import 'package:the_movies_flut/api/model/MovieData.dart';
import 'package:the_movies_flut/api/model/TVShow.dart';

class SimpleMovieItem {
  final int id;
  final String image;
  final String title;

  SimpleMovieItem({this.id, this.title, this.image});

  factory SimpleMovieItem.fromMovie(MovieData data) {
    return SimpleMovieItem(
        id: data.id,
        title: data.title,
        image: API.UrlBaseImage + data.poster_path);
  }

  factory SimpleMovieItem.fromTVShow(TVShowData data) {
    return SimpleMovieItem(
        id: data.id,
        title: data.name,
        image: API.UrlBaseImage + data.posterPath);
  }
}
