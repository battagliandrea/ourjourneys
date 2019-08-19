import 'dart:async';

import 'package:our_journeys/data/repository/poi_repository.dart';
import 'package:our_journeys/presentation/model/model.dart';

class FetchDaysUseCase {
  PoiRepository poiRepository;

  FetchDaysUseCase(PoiRepository poiRepository) {
    this.poiRepository = poiRepository;
  }

  Future<List<Day>> fetchDays() async {
   return await poiRepository.fetchDays();
  }
}