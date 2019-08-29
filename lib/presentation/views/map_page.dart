import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist_bloc.dart';
import 'package:our_journeys/domain/model/day.dart';

class MapPage extends StatefulWidget {

  MapPage({Key key, this.day}) : super(key: key);

  final Day day;

  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();

  final DayBloc _dayBloc = DayBloc();

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    _dayBloc.dispatch(FetchDays(widget.day.index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          _buildMapView(),
          _buildAppBar(),

        ],
      )
    );
  }

  Widget _buildAppBar() {
    return new Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: new AppBar(
            elevation: 0,
            backgroundColor: Colors.black12,
            title: new Text("${widget.day.getFormattedDate()}")
        )
    );
  }

  Widget _buildMapView() {
    var startPoint = new CameraPosition(
        target: this.widget.day.poi[0].getLatLng(),
        zoom: 14.0
    );

    var points = new List<LatLng>();

    this.widget.day.poi.forEach((p) => {
      points.add(p.getLatLng()),
      _markers.add(Marker(
        markerId: MarkerId(p.id.toString()),
        position: p.getLatLng(),
        infoWindow: InfoWindow(
          title: p.name,
          snippet: p.address,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ))
    });

    _polyline.add(Polyline(
      polylineId: PolylineId(this.widget.day.index.toString()),
      visible: true,
      points: points,
      color: Colors.orange,
    ));

    return GoogleMap(
      markers: _markers,
      polylines: _polyline,
      mapType: MapType.normal,
      initialCameraPosition: startPoint,
      onMapCreated: _onMapCreated,
      myLocationButtonEnabled: false,
    );
  }
}