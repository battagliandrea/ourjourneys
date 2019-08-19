import 'package:equatable/equatable.dart';

abstract class DayEvent extends Equatable {}

class FetchDays extends DayEvent {
  @override
  String toString() => 'Fetch';
}