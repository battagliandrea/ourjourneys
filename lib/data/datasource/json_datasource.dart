import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:our_journeys/data/mapper/journey_mapper.dart';
import 'package:our_journeys/data/model/model_json_journey.dart';
import 'package:our_journeys/injection/dependency_injection.dart';
import 'package:our_journeys/presentation/model/model.dart';


class JsonDataSource{

  Future<Journey> fetchJourney() async {
    try {

      String data = await DefaultAssetBundle.of(Injector.getContext()).loadString("assets/journey_amsterdam.json");
      dynamic json = jsonDecode(data);

      var journey = JsonJourney.fromMap(json);

      return JourneyMapper.transformJourney(json);

    } on HttpException catch (e) {
      return null;
    } catch (err) {
      return null;
    }
  }

}