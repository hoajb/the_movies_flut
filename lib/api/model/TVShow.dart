class TVShowData {
  String originalName;
  List<int> genreIds;
  String name;
  double popularity;
  List<String> originCountry;
  double voteCount;
  String firstAirDate;
  String backdropPath;
  String originalLanguage;
  int id;
  double voteAverage;
  String overview;
  String posterPath;

  TVShowData(
      {this.originalName,
      this.genreIds,
      this.name,
      this.popularity,
      this.originCountry,
      this.voteCount,
      this.firstAirDate,
      this.backdropPath,
      this.originalLanguage,
      this.id,
      this.voteAverage,
      this.overview,
      this.posterPath});

  TVShowData.fromJson(Map<String, dynamic> json) {
    originalName = json['original_name'];
    genreIds = json['genre_ids'].cast<int>();
    name = json['name'];
    popularity = json['popularity'];
    originCountry = json['origin_country'].cast<String>();
    voteCount = json['vote_count'].toDouble();
    firstAirDate = json['first_air_date'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    id = json['id'];
    voteAverage = json['vote_average'].toDouble();
    overview = json['overview'];
    posterPath = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_name'] = this.originalName;
    data['genre_ids'] = this.genreIds;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['origin_country'] = this.originCountry;
    data['vote_count'] = this.voteCount;
    data['first_air_date'] = this.firstAirDate;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['id'] = this.id;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    return data;
  }
}

class TVShowList {
  List<TVShowData> results;
  int page;
  int totalPages;
  int totalResults;

  TVShowList({
    this.results,
    this.page,
    this.totalPages,
    this.totalResults,
  });

  static TVShowList fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'];
    var resultsList = resultsJson != null ? resultsJson as List : null;

    var listData = resultsList != null
        ? resultsList.map((child) => TVShowData.fromJson(child))?.toList()
        : List();

    return TVShowList(
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
