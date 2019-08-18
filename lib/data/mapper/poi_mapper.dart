
import 'package:our_journeys/data/model/model_json_poi.dart';
import 'package:our_journeys/presentation/model/model.dart';

class PoiMapper {

  static List<Poi> transform(List<JsonPoi> resultSource) {
    List<Poi> resultList = new List<Poi>();
    if (resultSource != null) {
      resultSource.forEach((u) => resultList.add(new Poi(u)));
    }
    return resultList;
  }
}