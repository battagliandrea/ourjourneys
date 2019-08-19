
import 'package:our_journeys/data/mapper/day_mapper.dart';
import 'package:our_journeys/presentation/model/model.dart';

class JourneyMapper {

  static Journey transformJourney(dynamic json){
    return new Journey(
      json['id'],
      json['title'],
      DayMapper.transformListDay(json['days'])
    );
  }
}