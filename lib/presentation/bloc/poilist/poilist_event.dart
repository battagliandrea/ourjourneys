import 'package:equatable/equatable.dart';

abstract class PoiEvent extends Equatable {}

class Fetch extends PoiEvent {
  @override
  String toString() => 'Fetch';
}