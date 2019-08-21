import 'dart:async';

import 'package:our_journeys/data/repository/journey_repository.dart';
import 'package:our_journeys/presentation/model/model.dart';

class FetchDaysUseCase {
  JourneyRepository poiRepository;

  FetchDaysUseCase(JourneyRepository poiRepository) {
    this.poiRepository = poiRepository;
  }

  Future<List<Day>> fetchDays() async {
   return await poiRepository.fetchDays();
  }
}