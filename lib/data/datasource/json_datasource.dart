import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:our_journeys/data/mapper/poi_mapper.dart';
import 'package:our_journeys/injection/dependency_injection.dart';
import 'package:our_journeys/presentation/model/model.dart';


class JsonDataSource{

  Future<List<Poi>> fetchJsonList() async {
    try {

      String data = await DefaultAssetBundle.of(Injector.getContext()).loadString("assets/poi.json");
      List <dynamic> res = jsonDecode(data);
      return PoiMapper.transformListPoi(res);

    } on HttpException catch (e) {
      return [];
    } catch (err) {
      return [];
    }
  }


}