import 'package:equatable/equatable.dart';

import 'package:our_journeys/domain/model/models.dart';

abstract class PoiState extends Equatable {
  PoiState([List props = const []]) : super(props);
}

class PoiUninitialized extends PoiState {
  @override
  String toString() => "PoiUninitialized";
}

class PoiError extends PoiState {
  @override
  String toString() => "PoiError";
}

class PoiLoaded extends PoiState {
  final Day day;

  PoiLoaded(this.day) : super([day]);

//  PoiLoaded copyWith({
//    List<Poi> posts,
//  }){
//    return PoiLoaded(posts ?? this.poi);
//  }
}
