import 'dart:async';

import 'package:our_journeys/data/datasource/json_datasource.dart';
import 'package:our_journeys/presentation/model/model.dart';


abstract class PoiRepository {
  Future<List<Poi>> fetchPoi();
  Future<List<Day>> fetchDays();
}

class PoiRepositoryImpl implements PoiRepository {

  JsonDataSource jsonDataSource;

  PoiRepositoryImpl(JsonDataSource jsonDataSource) {
    this.jsonDataSource = jsonDataSource;
  }

  @override
  Future<List<Poi>> fetchPoi() async {
    Journey journey = await jsonDataSource.fetchJourney();

    if (journey.days[0].poi.length > 0) {
      return journey.days[0].poi;
    } else {
      return new List<Poi>();
    }
  }

  @override
  Future<List<Day>> fetchDays() async {
    Journey journey = await jsonDataSource.fetchJourney();

    if (journey.days.length > 0) {
      return journey.days;
    } else {
      return new List<Day>();
    }
  }
}