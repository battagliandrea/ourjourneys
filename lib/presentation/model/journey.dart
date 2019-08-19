import 'package:our_journeys/data/mapper/mappers.dart';
import 'package:our_journeys/data/model/model_json_poi.dart';
import 'package:our_journeys/presentation/model/day.dart';

class Journey {

  String id;
  String title;
  List<Day> days;

  Journey(this.id, this.title, this.days);

}