import 'package:equatable/equatable.dart';

abstract class DaysEvent extends Equatable {}


class FetchDays extends DaysEvent {

  final int selected;

  FetchDays(this.selected);

}