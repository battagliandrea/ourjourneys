import 'dart:async';

import 'package:our_journeys/data/datasource/json_datasource.dart';
import 'package:our_journeys/presentation/model/model.dart';


abstract class JourneyRepository {
  Future<List<Poi>> fetchPoi(int index);
  Future<List<Day>> fetchDays();
}

class JourneyRepositoryImpl implements JourneyRepository {

  JsonDataSource jsonDataSource;

  JourneyRepositoryImpl(JsonDataSource jsonDataSource) {
    this.jsonDataSource = jsonDataSource;
  }

  @override
  Future<List<Poi>> fetchPoi(int index) async {
    Journey journey = await jsonDataSource.fetchJourney();
    return journey.days[index].poi;
  }

  @override
  Future<List<Day>> fetchDays() async {
    Journey journey = await jsonDataSource.fetchJourney();
    return journey.days;
  }
}