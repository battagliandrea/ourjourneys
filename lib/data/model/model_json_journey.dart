
class JsonJourney {

  String id;
  String title;
  List<JsonDay> days;

  JsonJourney.fromMap(dynamic json) :
    id = json['id'],
    title = json['title'],
    days = new List<JsonDay>.from(json["days"].map((p) => JsonDay.fromMap(p)).toList());
}

class JsonDay {

  int index;
  String date;
  List<JsonPoi> poi;

  JsonDay.fromMap(dynamic json) :
    index = json['index'],
    date = json['date'],
    poi = new List<JsonPoi>.from(json['poi'].map((p) => JsonPoi.fromMap(p)).toList());
}


class JsonPoi {

  int id;
  String name;
  String description;
  String address;
  String image;
  JsonCoordinate coordinates;

  JsonPoi.fromMap(dynamic json) :
    id = json['id'],
    name = json['name'],
    description = json['description'],
    address = json['address'],
    image = json['image'],
    coordinates = JsonCoordinate.fromMap(json['coordinates']);
}



class JsonCoordinate {

  double lat;
  double lon;

  JsonCoordinate.fromMap(dynamic json) {
    lat = json['lat'];
    lon = json['lon'];
  }

}