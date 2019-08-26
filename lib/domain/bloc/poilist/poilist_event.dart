import 'package:equatable/equatable.dart';

abstract class PoiEvent extends Equatable {}

class FetchPoi extends PoiEvent {

  final int index;

  FetchPoi(this.index);
}