class JsonPoi {

  int id;
  
  String name;
  
  String address;

  JsonPoi.fromMap(dynamic json) :
        id = json['id'],
        name = json['name'],
        address = json['address'];
}