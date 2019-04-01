import 'package:the_movies_flut/api/API.dart';
import 'package:the_movies_flut/api/model/Person.dart';

class SimplePeople {
  final int id;
  final String image;
  final String name;

  SimplePeople({this.id, this.name, this.image});

  factory SimplePeople.fromPerson(Person data) {
    return SimplePeople(
        id: data.id,
        name: data.name,
        image: (data.profilePath != null && data.profilePath.contains(".jpg"))
            ? API.urlBaseImage + data.profilePath
            : "");
  }
}
