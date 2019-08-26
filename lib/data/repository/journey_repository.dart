import 'dart:async';

import 'package:our_journeys/data/datasource/json_datasource.dart';
import 'package:our_journeys/domain/model/models.dart';


abstract class JourneyRepository {
  Future<List<Poi>> fetchPoi(int index);
  Future<List<Day>> fetchDays();
  Future<Day> fetchDayByIndex(int index);
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

  @override
  Future<Day> fetchDayByIndex(int index) async {
    Journey journey = await jsonDataSource.fetchJourney();
    return journey.days[index];
  }
}