import 'package:the_movies_flut/api/model/MovieData.dart';

class Person {
  double popularity;
  int id;
  String profilePath;
  String name;
  List<MovieData> knownFor;
  bool adult;

  Person(
      {this.popularity,
      this.id,
      this.profilePath,
      this.name,
      this.knownFor,
      this.adult});

  Person.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'] ?? 0;
    id = json['id'] ?? 0;
    profilePath = json['profile_path'] ?? "";
    name = json['name'] ?? "";
    if (json['known_for'] != null) {
      knownFor = new List<MovieData>();
      json['known_for'].forEach((v) {
        knownFor.add(MovieData.fromJson(v));
      });
    }
    adult = json['adult'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['id'] = this.id;
    data['profile_path'] = this.profilePath;
    data['name'] = this.name;
    if (this.knownFor != null) {
      data['known_for'] = this.knownFor.map((v) => v.toJson()).toList();
    }
    data['adult'] = this.adult;
    return data;
  }

//  /*temp json*/
//  static Person fake() {
//    final parsed = json.decode();
//    return Person.fromJson();
//  }
}

class PersonList {
  List<Person> results;
  int page;
  int totalPages;
  int totalResults;

  PersonList({
    this.results,
    this.page,
    this.totalPages,
    this.totalResults,
  });

  static PersonList fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'];
    var resultsList = resultsJson != null ? resultsJson as List : null;

    var listData = resultsList != null
        ? resultsList.map((child) => Person.fromJson(child))?.toList()
        : List();
    return PersonList(
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

/**
    {
    "popularity": 30.221,
    "id": 976,
    "profile_path": "/PhWiWgasncGWD9LdbsGcmxkV4r.jpg",
    "name": "Jason Statham",
    "known_for": [
    {
    "vote_average": 6.7,
    "vote_count": 6864,
    "id": 82992,
    "video": false,
    "media_type": "movie",
    "title": "Fast & Furious 6",
    "popularity": 1.648,
    "poster_path": "/b9gTJKLdSbwcQRKzmqMq3dMfRwI.jpg",
    "original_language": "en",
    "original_title": "Fast & Furious 6",
    "genre_ids": [
    28,
    53,
    80
    ],
    "backdrop_path": "/qjfE7SkPXpqFs8FX8rIaG6eO2aK.jpg",
    "adult": false,
    "overview": "Hobbs has Dominic and Brian reassemble their crew to take down a team of mercenaries: Dominic unexpectedly gets convoluted also facing his presumed deceased girlfriend, Letty.",
    "release_date": "2013-05-21"
    },
    {
    "vote_average": 7.3,
    "vote_count": 6297,
    "id": 168259,
    "video": false,
    "media_type": "movie",
    "title": "Furious 7",
    "popularity": 19.893,
    "poster_path": "/dCgm7efXDmiABSdWDHBDBx2jwmn.jpg",
    "original_language": "en",
    "original_title": "Furious 7",
    "genre_ids": [
    28,
    80,
    53,
    18
    ],
    "backdrop_path": "/ypyeMfKydpyuuTMdp36rMlkGDUL.jpg",
    "adult": false,
    "overview": "Deckard Shaw seeks revenge against Dominic Toretto and his family for his comatose brother.",
    "release_date": "2015-04-01"
    },
    {
    "vote_average": 6.9,
    "vote_count": 6078,
    "id": 337339,
    "video": false,
    "media_type": "movie",
    "title": "The Fate of the Furious",
    "popularity": 33.66,
    "poster_path": "/dImWM7GJqryWJO9LHa3XQ8DD5NH.jpg",
    "original_language": "en",
    "original_title": "The Fate of the Furious",
    "genre_ids": [
    12,
    28,
    80,
    53,
    9648
    ],
    "backdrop_path": "/jzdnhRhG0dsuYorwvSqPqqnM1cV.jpg",
    "adult": false,
    "overview": "When a mysterious woman seduces Dom into the world of crime and a betrayal of those closest to him, the crew face trials that will test them as never before.",
    "release_date": "2017-04-12"
    }
    ],
    "adult": false
    }
 **/
