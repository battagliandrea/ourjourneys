import 'package:google_maps_flutter/google_maps_flutter.dart';

class Poi{

  int id;
  String name;
  String address;
  double lat;
  double lon;

  Poi(this.id, this.name, this.address, this.lat, this.lon);

  LatLng getLatLng(){
    return new LatLng(lat, lon);
  }
}