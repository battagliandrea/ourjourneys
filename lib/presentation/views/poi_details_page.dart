import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoiDetailsPage extends StatefulWidget {

  PoiDetailsPage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _PoiDatailsPageState createState() => new _PoiDatailsPageState();
}

class _PoiDatailsPageState extends State<PoiDetailsPage> {

    Completer<GoogleMapController> _controller = Completer();

    static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 11.09,
    );

    static final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Details Page"),
        ),
        body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      );
    }
}