import 'package:equatable/equatable.dart';

import 'package:our_journeys/presentation/model/model.dart';

abstract class DayState extends Equatable {
  DayState([List props = const []]) : super(props);
}

class DayUninitialized extends DayState {
  @override
  String toString() => "PoiUninitialized";
}

class DayError extends DayState {
  @override
  String toString() => "PoiError";
}

class DayLoaded extends DayState {
  final List<Day> days;

  DayLoaded(this.days) : super(days);

  DayLoaded copyWith({
    List<Poi> posts,
  }){
    return DayLoaded(posts ?? this.days);
  }
}
