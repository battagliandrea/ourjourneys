import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist_bloc.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist_state.dart';
import 'package:our_journeys/domain/bloc/poilist/poilist.dart';
import 'package:our_journeys/domain/bloc/poilist/poilist_bloc.dart';
import 'package:our_journeys/domain/model/models.dart';
import 'package:our_journeys/presentation/utils/colors.dart';
import 'package:our_journeys/presentation/utils/dimens.dart';
import 'package:our_journeys/presentation/utils/typography.dart';
import 'package:our_journeys/presentation/views/map_page.dart';
import 'package:our_journeys/presentation/views/poi_detail_page.dart';
import 'package:our_journeys/presentation/widgets/horizontal_line.dart';


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//          PAGE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class PoiListPage extends StatefulWidget {

  Day selectedDay;

  @override
  _PoiListPageState createState() => new _PoiListPageState();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//          PAGE STATE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class _PoiListPageState extends State<PoiListPage> {


  final PoiBloc _postBloc = PoiBloc();
  final DayBloc _dayBloc = DayBloc();

  @override
  void initState() {
    super.initState();
    _postBloc.dispatch(FetchPoi(0));
    _dayBloc.dispatch(FetchDays(0));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:_buildListView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton:
          new FloatingActionButton(
            backgroundColor: OJColors.yellow,
            child: const Icon(Icons.map), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(day: this.widget.selectedDay)));
            },
          ),
        bottomNavigationBar: _buildBottomAppBar()
    );
  }


  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          BOTTOM APP BAR
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 8.0,
      color: OJColors.purple,
      shape: CircularNotchedRectangle(),
      notchMargin: OJDimens.standardHalfDistance,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.menu), color: OJColors.iconColor, onPressed: () {
            _settingModalBottomSheet(context);
          },),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          POI LIST VIEW
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildListView() {
    return BlocBuilder(
        bloc: _postBloc,
        builder: (BuildContext context, PoiState state){
          if(state is PoiLoaded){

            this.widget.selectedDay = state.day;

            return new Stack(
              children: <Widget>[

                new Container(
                  child: new CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: <Widget>[

                      new SliverToBoxAdapter(
                        child: new Container(
                          padding: const EdgeInsets.only(top: 100.0, left: OJDimens.standardQuadrupleDistance, right: OJDimens.standardQuadrupleDistance),
                          child: new Text("${state.day.getFormattedDate()}", style: OJTypography.h4FontMain, maxLines: 1, overflow: TextOverflow.ellipsis),
                          height: 150,
                        ),
                      ),

                      new SliverToBoxAdapter(
                        child: new HorizontalLine(
                          color: OJColors.purple,
                          height: OJDimens.lineHorizontalHeight,
                          paddingStart: OJDimens.standardQuadrupleDistance,
                          radiusTopLeft: Radius.circular(OJDimens.radius),
                          radiusBottomLeft: Radius.circular(OJDimens.radius),
                        )
                      ),

                      new SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: OJDimens.standardDistance),
                        sliver: new SliverFixedExtentList(
                          itemExtent: 152.0,
                          delegate: new SliverChildBuilderDelegate((context, index) =>
                              _buildRow(context, index, state.day.poi[index]),
                            childCount: state.day.poi.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          else{
            return Center(
                child: Text('Error!!') //TODO fix error!!
            );
          }
        }
    );
  }

  Widget _buildRow(context, int index, Poi poi) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PoiDetailPage(poi: poi)));
      },
      child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: OJDimens.standardDistance,
            horizontal: OJDimens.standardDistance,
          ),
          child: new Stack(
            children: <Widget>[


              new Container(
                height: OJDimens.rowPoiHeight,
                margin: new EdgeInsets.only(left: OJDimens.standardQuadrupleDistance),
                padding: new EdgeInsets.only(left: OJDimens.standardQuadrupleDistance, right: OJDimens.standardDistance),
                decoration: new BoxDecoration(
                  color: OJColors.cardColor,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.only(topRight: const Radius.circular(OJDimens.standardDoubleDistance), bottomRight: const Radius.circular(OJDimens.standardQuarterDistance)),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: OJColors.shadowColor,
                      blurRadius: 10.0,
                      offset: new Offset(-10.0, 0.0),
                    ),
                  ],
                ),
              ),


              new Container(
                margin: new EdgeInsets.symmetric(
//                  vertical: 16.0
                ),
                alignment: FractionalOffset.centerLeft,
                child: new Container(
                    width: OJDimens.rowPoiHeight,
                    height: OJDimens.rowPoiHeight,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: OJColors.cardColor,
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          color: OJColors.shadowColor,
                          blurRadius: 10.0,
                          offset: new Offset(-15.0, 0.0),
                        ),
                      ],
                    )),
              ),

              new Container(
                height: OJDimens.rowPoiHeight,
                margin: new EdgeInsets.only(left: OJDimens.standardQuadrupleDistance, right: OJDimens.standardDistance),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("${poi.name}", style: OJTypography.h6FontMain, maxLines: 1, overflow: TextOverflow.ellipsis),
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
                    new Text("${poi.address}", style: OJTypography.b1FontMain)
                  ],
                ),
              )

            ],
          )
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          BOTTOM SHEET
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return BlocBuilder(
              bloc: _dayBloc,
              builder: (BuildContext context, DaysState state){

                if(state is DaysLoaded){
                  return new Container(
                      child: new ListView.builder(
                          itemCount: state.days.length,
                          itemBuilder: (BuildContext _context, int i) {
                            return _buildDayRow(_context, i, state.days.length, state.days[i]);
                          }
                      )
                  );
                }

                else {
                  return Container();
                }

              }
          );
        }
    );
  }

  Widget _buildDayRow(context, int index, int lastIndex, Day day) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
        _postBloc.dispatch(FetchPoi(day.index));
        _dayBloc.dispatch(FetchDays(day.index));
      },
      child: new Container(
          padding: EdgeInsets.symmetric(horizontal: OJDimens.standardDistance),
          height: OJDimens.rowDayHeight,
          child: new Stack(
            children: <Widget>[

              _buildDayRowLine(context, index, lastIndex),

              _buildDayRowPoint(context),

              new Container(
                margin: new EdgeInsets.only(left: OJDimens.standardQuadrupleDistance, right: OJDimens.standardDistance),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("${day.getFormattedDate()}", style: OJTypography.h6FontMain, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),

            ],
          )
      ),
    );
  }


  Widget _buildDayRowLine(BuildContext context, int index, int lastIndex,) {
    Widget child;
    if (index == 0) {
      child = new Container(
        margin: EdgeInsets.only(top: OJDimens.standardDoubleDistance, left: OJDimens.standardHalfDistance),
        width: OJDimens.lineVerticalWidth,
        height: OJDimens.standardDoubleDistance,
        color: OJColors.yellow,
      );
    } else if(index == lastIndex-1) {
      child = new Container(
        margin: EdgeInsets.only(bottom: OJDimens.standardDoubleDistance, left: OJDimens.standardHalfDistance),
        width: OJDimens.lineVerticalWidth,
        height: OJDimens.standardDoubleDistance,
        color: OJColors.yellow,
      );
    } else {
      child = new Container(
        margin: EdgeInsets.only(left: OJDimens.standardHalfDistance),
        width: OJDimens.lineVerticalWidth,
        height: OJDimens.standardQuadrupleDistance,
        color: OJColors.yellow,
      );
    }
    return child;
  }

  Widget _buildDayRowPoint(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.centerLeft,
      child: new Container(
          width: OJDimens.circleDimens,
          height: OJDimens.circleDimens,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: OJColors.white,
            border: Border.all(color: OJColors.black, width: OJDimens.lineVerticalWidth)
          )),
    );
  }


  void _showInSnackBar(context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }


}