import 'dart:async';

import 'package:our_journeys/data/datasource/json_datasource.dart';
import 'package:our_journeys/presentation/model/model.dart';


abstract class PoiRepository {
  Future<List<Poi>> fetchPoi();
}

class PoiRepositoryImpl implements PoiRepository {

  JsonDataSource jsonDataSource;

  PoiRepositoryImpl(JsonDataSource jsonDataSource) {
    this.jsonDataSource = jsonDataSource;
  }

  @override
  Future<List<Poi>> fetchPoi() async {
    List<Poi> poi = await jsonDataSource.fetchJsonList();

    if (poi.length > 0) {
      return poi;
    } else {
      return new List<Poi>();
    }
  }
}