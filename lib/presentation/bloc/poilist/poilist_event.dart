import 'package:equatable/equatable.dart';

abstract class PoiEvent extends Equatable {}

class FetchPost extends PoiEvent {
  @override
  String toString() => 'Fetch';
}