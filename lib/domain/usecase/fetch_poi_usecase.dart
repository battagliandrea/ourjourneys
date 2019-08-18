import 'dart:async';

import 'package:our_journeys/data/repository/poi_repository.dart';
import 'package:our_journeys/presentation/model/model.dart';

class FetchPoiUseCase {
  PoiRepository poiRepository;

  FetchPoiUseCase(PoiRepository poiRepository) {
    this.poiRepository = poiRepository;
  }

  Future<List<Poi>> fetchPoi() async {
   return await poiRepository.fetchPoi();
  }
}