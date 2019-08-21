
import 'package:our_journeys/data/model/model_json_journey.dart';
import 'package:our_journeys/presentation/model/model.dart';

class JourneyMapper {

  static Journey transformJourney(JsonJourney jsonModel){
    return new Journey(
      jsonModel.id,
      jsonModel.title,
      transformListDay(jsonModel.days)
    );
  }


  static List<Day> transformListDay(List<JsonDay> jsonModel){
    return jsonModel
        .map((p) => transformDay(p))
        .toList();
  }

  static Day transformDay(JsonDay jsonModel){
    return new Day(
        jsonModel.index,
        DateTime.parse(jsonModel.date),
        transformListPoi(jsonModel.poi)
    );
  }

  static List<Poi> transformListPoi(List<JsonPoi> jsonModel){
    return jsonModel
        .map((p) => transformPoi(p))
        .toList();
  }

  static Poi transformPoi(JsonPoi jsonModel){
    return new Poi(
        jsonModel.id,
        jsonModel.name,
        jsonModel.address,
        jsonModel.coordinates.lat,
        jsonModel.coordinates.lon
    );
  }
}