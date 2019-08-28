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
    return CustomScrollView(
      slivers: <Widget>[
        _buildAppBar(),
        _buildBody(poi)
      ],
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //         APP BAR VIEW
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: true,
      pinned: true,
      snap: false,
      flexibleSpace: new FlexibleSpaceBar(
          centerTitle: true,
          title: new Text(widget.poi.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          background: Image.network(
            "https://www.viviamsterdam.it/images/viviamsterdam/Trasporti/Amsterdam-stazione-centrale.jpg",
            fit: BoxFit.cover,
          )
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //         BODY
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildBody(Poi poi) {
    return new SliverToBoxAdapter(
      child: new Container(
        padding: new EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("${poi.address}", style: _H1Font),
            new Text("${poi.description}", style: _B1Font),
          ],
        ),
      )
    );
  }

}