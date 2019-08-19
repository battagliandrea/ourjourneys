
import 'package:our_journeys/data/mapper/mappers.dart';
import 'package:our_journeys/presentation/model/model.dart';

class DayMapper {

  static List<Day> transformListDay(List<dynamic> res){
    return res
        .map((p) => transformDay(p))
        .toList();
  }

  static Day transformDay(dynamic json){
    return new Day(
      json['index'],
      PoiMapper.transformListPoi(json['poi'])
    );
  }
}