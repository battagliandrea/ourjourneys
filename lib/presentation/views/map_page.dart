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
    final Set<Marker> _markers = {};

    final DayBloc _dayBloc = DayBloc();

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
//        body: GoogleMap(
//          markers: _markers,
//          mapType: MapType.normal,
//          initialCameraPosition: _kGooglePlex,
//          onMapCreated: _onMapCreated,
//        ),
      );
    }

    Widget _buildMapView() {
      return BlocBuilder(
          bloc: _dayBloc,
          builder: (BuildContext context, DaysState state){
            if(state is DaysLoaded){

              state.selectedDay.poi.forEach((p) =>
                  _markers.add(Marker(
                    markerId: MarkerId(p.id.toString()),
                    position: LatLng(p.lat, p.lon),
                    infoWindow: InfoWindow(
                      title: p.name,
                      snippet: p.address,
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                  ))
              );

              return GoogleMap(
                markers: _markers,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: false,
              );
            }
            return GoogleMap(onMapCreated: _onMapCreated);
          }
      );
    }
}