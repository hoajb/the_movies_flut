import 'package:equatable/equatable.dart';

abstract class PeopleRowListEvent extends Equatable {}

class FetchInitEvent extends PeopleRowListEvent {
  @override
  String toString() => 'FetchInitEvent';
}

class FetchMoreEvent extends PeopleRowListEvent {
  @override
  String toString() => 'FetchMoreEvent';
}
