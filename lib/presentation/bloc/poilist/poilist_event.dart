import 'package:equatable/equatable.dart';

abstract class PoiEvent extends Equatable {}

class FetchPost extends PoiEvent {

  final int index;

  FetchPost(this.index);

  @override
  String toString() => 'Fetch';
}