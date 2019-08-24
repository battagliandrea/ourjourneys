import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {

  MapPage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {

    Completer<GoogleMapController> _controller = Completer();
    final Set<Marker> _markers = {};


    static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(52.373170, 4.890660),
      zoom: 14.0,
    );

    static final CameraPosition _testPosition = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(52.378100, 4.900020),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    static final LatLng _testPosition2 = LatLng(52.378100, 4.900020);

    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);


      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(52.378100.toString()),
        position: _testPosition2,
        infoWindow: InfoWindow(
          title: 'Amsterdam Station',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Map"),
        ),
        body: GoogleMap(
          markers: _markers,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: _onMapCreated,
        ),
      );
    }
}