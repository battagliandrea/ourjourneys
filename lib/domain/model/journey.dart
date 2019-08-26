import 'package:our_journeys/domain/model/day.dart';

class Journey {

  String id;
  String title;
  List<Day> days;

  Journey(this.id, this.title, this.days);
}