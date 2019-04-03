class Video {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  Video(
      {this.id,
      this.iso6391,
      this.iso31661,
      this.key,
      this.name,
      this.site,
      this.size,
      this.type});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    iso6391 = json['iso_639_1'] ?? '';
    iso31661 = json['iso_3166_1'] ?? '';
    key = json['key'] ?? '';
    name = json['name'] ?? '';
    site = json['site'] ?? '';
    size = json['size'] ?? 0;
    type = json['type'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso_639_1'] = this.iso6391;
    data['iso_3166_1'] = this.iso31661;
    data['key'] = this.key;
    data['name'] = this.name;
    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}

class VideoList {
  List<Video> results;

  VideoList({
    this.results,
  });

  static VideoList fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'];
    var resultsList = resultsJson != null ? resultsJson as List : null;

    var listData = resultsList != null
        ? resultsList.map((child) => Video.fromJson(child))?.toList()
        : List();
    return VideoList(
      results: listData,
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results,
      };
}

/**
 * {
    "id": "5bd5ba940e0a2622d102f5b4",
    "iso_639_1": "en",
    "iso_3166_1": "US",
    "key": "qLTDtbYmdWM",
    "name": "HOW TO TRAIN YOUR DRAGON: THE HIDDEN WORLD | Official Trailer 2",
    "site": "YouTube",
    "size": 1080,
    "type": "Trailer"
    }
 **/
