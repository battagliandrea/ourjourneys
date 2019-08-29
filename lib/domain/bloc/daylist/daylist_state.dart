import 'package:equatable/equatable.dart';

import 'package:our_journeys/domain/model/models.dart';

abstract class DaysState extends Equatable {
  DaysState([List props = const []]) : super(props);
}

class DayUninitialized extends DaysState {
  @override
  String toString() => "PoiUninitialized";
}

class DayError extends DaysState {
  @override
  String toString() => "PoiError";
}

class DaysLoaded extends DaysState {
  final List<Day> days;

  DaysLoaded(this.days) : super([days]);

//  DaysLoaded copyWith({
//    List<Poi> posts,
//  }){
//    return DaysLoaded(posts ?? this.days);
//  }
}
