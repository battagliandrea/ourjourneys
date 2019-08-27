import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist_bloc.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist_state.dart';
import 'package:our_journeys/domain/bloc/poilist/poilist.dart';
import 'package:our_journeys/domain/bloc/poilist/poilist_bloc.dart';
import 'package:our_journeys/domain/model/models.dart';
import 'package:our_journeys/presentation/views/map_page.dart';

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//          PAGE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class PoiDetailPage extends StatefulWidget {
  PoiDetailPage({Key key, this.poi}) : super(key: key);

  final Poi poi;

  @override
  _PoiDetailPageState createState() => new _PoiDetailPageState();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//          PAGE STATE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class _PoiDetailPageState extends State<PoiDetailPage> {

  final TextStyle _H1Font = const TextStyle(color: Colors.black87, fontSize: 21.0, fontWeight: FontWeight.bold);
  final TextStyle _B1Font = const TextStyle(color: Colors.black38, fontSize: 14.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildCollapsingLayout(widget.poi)
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //         COLLAPSIBG VIEW
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildCollapsingLayout(Poi poi) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: _buildAppBar(),
          ),
        ];
      },
      body: _buildBody(poi)
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //         APP BAR VIEW
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildAppBar() {
    return new FlexibleSpaceBar(
        centerTitle: true,
        title: new Text(widget.poi.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        background: Image.network(
          "https://www.viviamsterdam.it/images/viviamsterdam/Trasporti/Amsterdam-stazione-centrale.jpg",
          fit: BoxFit.cover,
        )
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //         BODY
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildBody(Poi poi) {
    return new Container(
      padding: new EdgeInsets.all(24.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("${poi.address}", style: _B1Font),
        ],
      ),
    );
  }

}