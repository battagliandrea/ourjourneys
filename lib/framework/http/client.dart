import 'dart:async';

import 'package:our_journeys/framework/http/simple_client.dart';


class Client extends SimpleClient {
  String baseUrl;

  Client({String baseUrl}) :
        this.baseUrl = baseUrl;

  @override
  Future sendRequest (SimpleRequest request) {
    return super.sendRequest(request);
  }

}
