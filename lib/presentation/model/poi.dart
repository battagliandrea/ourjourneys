import 'package:our_journeys/data/mapper/mappers.dart';
import 'package:our_journeys/data/model/model_json_poi.dart';

class Poi implements Convert<JsonPoi, Poi> {

  int id;
  String name;
  String address;
  double lat;
  double long;

  Poi(JsonPoi fromModel) {
    id = fromModel.id;
    name = fromModel.name;
    address = fromModel.address;
    lat = fromModel.coordinates.lat;
    long = fromModel.coordinates.long;
  }

  @override
  Poi fromSourceModel(JsonPoi fromModel) {
    return new Poi(fromModel);
  }
}