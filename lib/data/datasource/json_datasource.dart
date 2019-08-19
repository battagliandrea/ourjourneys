import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:our_journeys/data/mapper/journey_mapper.dart';
import 'package:our_journeys/injection/dependency_injection.dart';
import 'package:our_journeys/presentation/model/model.dart';


class JsonDataSource{

  Future<List<Poi>> fetchJsonList() async {
    try {

      String testData = await DefaultAssetBundle.of(Injector.getContext()).loadString("assets/journey_amsterdam.json");
      dynamic testDecoded = jsonDecode(testData);

      var journey = JourneyMapper.transformJourney(testDecoded);
      return journey.days[0].poi;

    } on HttpException catch (e) {
      return [];
    } catch (err) {
      return [];
    }
  }

}