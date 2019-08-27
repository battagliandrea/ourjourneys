import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        appBar: AppBar(
          title: Text("${widget.day.getFormattedDate()}"),
        ),
        body: _buildMapView()
    );
  }

  Widget _buildMapView() {
    return BlocBuilder(
        bloc: _dayBloc,
        builder: (BuildContext context, DaysState state){
          if(state is DaysLoaded){

            var startPoint = new CameraPosition(
              target: state.selectedDay.poi[0].getLatLng(),
              zoom: 14.0
            );

            var points = new List<LatLng>();

            state.selectedDay.poi.forEach((p) => {
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
              polylineId: PolylineId(state.selectedDay.index.toString()),
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
          return GoogleMap(onMapCreated: _onMapCreated);
        }
    );
  }
}