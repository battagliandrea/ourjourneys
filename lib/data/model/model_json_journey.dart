
import 'package:our_journeys/presentation/model/model.dart';

class JsonJourney {

  String id;
  String title;
  List<dynamic> days;

  JsonJourney.fromMap(dynamic json) :
    id = json['id'],
    title = json['title'],
    days = json["days"].map((p) => JsonDay.fromMap(p)).toList();
}

class JsonDay {

  int index;
  String date;
  List<dynamic> poi;

  JsonDay JsonDay.fromMap(dynamic json) :
    index = json['index'],
    date = json['date'],
    poi = json['poi'].map((p) => JsonPoi.fromMap(p)).toList();
}


class JsonPoi {

  int id;
  String name;
  String address;
  JsonCoordinate coordinates;

  JsonPoi.fromMap(dynamic json) :
    id = json['id'],
    name = json['name'],
    address = json['address'],
    coordinates = JsonCoordinate.fromMap(json['coordinates']);
}



class JsonCoordinate {

  double lat;
  double long;

  JsonCoordinate.fromMap(dynamic json) {
    lat = json['lat'];
    long = json['long'];
  }

}