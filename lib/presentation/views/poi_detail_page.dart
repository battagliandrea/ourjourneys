import 'package:flutter/material.dart';
import 'package:our_journeys/domain/model/models.dart';
import 'package:our_journeys/presentation/utils/colors.dart';
import 'package:our_journeys/presentation/utils/dimens.dart';
import 'package:our_journeys/presentation/utils/typography.dart';
import 'package:our_journeys/presentation/widgets/horizontal_line.dart';

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

  var top = 0.0;

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
        _buildAppBar(poi),
        _buildBody(poi)
      ],
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //         APP BAR VIEW
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildAppBar(Poi poi) {
    return SliverAppBar(
      expandedHeight: OJDimens.expandableHeaderHeight,
      floating: true,
      pinned: true,
      snap: false,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {

            top = constraints.biggest.height;

            return new FlexibleSpaceBar(
                centerTitle: true,
                title: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: top < 200 ? 1.0 : 0.0,
                    child: Text("${widget.poi.name}", style: OJTypography.h6FontSecondary)
                ),
                background: Image.network(poi.image,fit: BoxFit.cover));
          }
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
              new Text("${poi.address}", style: OJTypography.h6FontMain),
              new HorizontalLine(
                color: OJColors.yellow,
                height: OJDimens.lineHorizontalHeight,
                width: OJDimens.lineHorizontalWidth,
                paddingTop: OJDimens.standardHalfDistance,
                paddingBottom: OJDimens.standardHalfDistance,
                radiusTopLeft: Radius.circular(OJDimens.radius),
                radiusBottomLeft: Radius.circular(OJDimens.radius),
                radiusTopRight: Radius.circular(OJDimens.radius),
                radiusBottomRight: Radius.circular(OJDimens.radius),
              ),
              new Text("${poi.description}", style: OJTypography.b1FontMain),
            ],
          ),
        )
    );
  }

}