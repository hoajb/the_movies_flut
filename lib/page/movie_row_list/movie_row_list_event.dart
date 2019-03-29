import 'package:equatable/equatable.dart';

abstract class MovieRowListEvent extends Equatable {}

class FetchInitEvent extends MovieRowListEvent {
  @override
  String toString() => 'FetchInitEvent';
}

class FetchMoreEvent extends MovieRowListEvent {
  @override
  String toString() => 'FetchMoreEvent';
}
