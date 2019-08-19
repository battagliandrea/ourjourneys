
import 'package:our_journeys/presentation/model/model.dart';

class PoiMapper {

  static List<Poi> transformListPoi(List<dynamic> res){
    return res
        .map((p) => transformPoi(p))
        .toList();
  }

  static Poi transformPoi(dynamic json){
    return new Poi(
      json['id'],
      json['name'],
      json['address'],
      0.0,
      0.0
    );
  }
}