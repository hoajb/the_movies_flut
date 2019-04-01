class MovieData {
  String vote_count;
  int id;
  bool video;
  String vote_average;
  String title;
  String popularity;
  String poster_path;
  String original_language;
  String original_title;
  List<int> genre_ids;
  String backdrop_path;
  bool adult;
  String overview;
  String release_date;

  MovieData({
    this.vote_count,
    this.id,
    this.video,
    this.vote_average,
    this.title,
    this.popularity,
    this.poster_path,
    this.original_language,
    this.original_title,
    this.genre_ids,
    this.backdrop_path,
    this.adult,
    this.overview,
    this.release_date,
  });

  static MovieData fromJson(Map<String, dynamic> json) {
//    print(json["vote_average"]?.runtimeType);
    return new MovieData(
      vote_count: json['vote_count'].toString(),
      id: json['id'],
      video: json['video'],
      vote_average: json['vote_average'].toString(),
      title: json['title'].toString(),
      popularity: json['popularity'].toString(),
      poster_path: json['poster_path'].toString(),
      original_language: json['original_language'].toString(),
      original_title: json['original_title'].toString(),
      genre_ids: json['genre_ids'].cast<int>(),
      backdrop_path: json['backdrop_path'].toString(),
      adult: json['adult'],
      overview: json['overview'].toString(),
      release_date: json['release_date'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'vote_count': vote_count,
        'id': id,
        'video': video,
        'vote_average': vote_average,
        'title': title,
        'popularity': popularity,
        'poster_path': poster_path,
        'original_language': original_language,
        'original_title': original_title,
        'genre_ids': genre_ids,
        'backdrop_path': backdrop_path,
        'adult': adult,
        'overview': overview,
        'release_date': release_date,
      };
}

class MovieList {
  List<MovieData> results;
  int page;
  int totalPages;
  int totalResults;

  MovieList({
    this.results,
    this.page,
    this.totalPages,
    this.totalResults,
  });

  static MovieList fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'];
    var resultsList = resultsJson != null ? resultsJson as List : null;

    var listData = resultsList != null
        ? resultsList.map((child) => MovieData.fromJson(child))?.toList()
        : List();
    return MovieList(
        results: listData,
        page: json['page'],
        totalPages: json['total_pages'],
        totalResults: json['total_results']);
  }

  Map<String, dynamic> toJson() => {
        'results': results,
        'page': page,
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}
