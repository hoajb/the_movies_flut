import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {}

class Fetch extends MoviesEvent {
  @override
  String toString() => 'Fetch';
}