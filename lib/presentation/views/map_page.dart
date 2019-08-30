import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist_bloc.dart';
import 'package:our_journeys/domain/model/day.dart';
import 'package:our_journeys/presentation/utils/colors.dart';
import 'package:our_journeys/presentation/utils/dimens.dart';
import 'package:our_journeys/presentation/utils/typography.dart';

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
      appBar: _buildAppBar(),
      body: new Stack(
        children: <Widget>[
          _buildMapView(),
        ],
      )
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
          iconTheme: IconThemeData(
            color: OJColors.white
          ),
          elevation: OJDimens.elevationNope,
          backgroundColor: OJColors.overlayColor,
          title: new Text("${widget.day.getFormattedDate()}", style: OJTypography.h6FontSecondary)
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
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ))
    });

    _polyline.add(Polyline(
      polylineId: PolylineId(this.widget.day.index.toString()),
      visible: true,
      points: points,
      color: OJColors.purple,
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