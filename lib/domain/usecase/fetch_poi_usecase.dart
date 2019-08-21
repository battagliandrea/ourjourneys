import 'dart:async';

import 'package:our_journeys/data/repository/journey_repository.dart';
import 'package:our_journeys/presentation/model/model.dart';

class FetchPoiUseCase {
  JourneyRepository poiRepository;

  FetchPoiUseCase(JourneyRepository poiRepository) {
    this.poiRepository = poiRepository;
  }

  Future<List<Poi>> fetchPoi(int index) async {
   return await poiRepository.fetchPoi(index);
  }
}