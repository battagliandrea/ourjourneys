import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist_bloc.dart';
import 'package:our_journeys/domain/bloc/daylist/daylist_state.dart';
import 'package:our_journeys/domain/bloc/poilist/poilist.dart';
import 'package:our_journeys/domain/bloc/poilist/poilist_bloc.dart';
import 'package:our_journeys/domain/model/models.dart';
import 'package:our_journeys/presentation/views/map_page.dart';

import 'package:our_journeys/presentation/utils/typography.dart' as Typography;
import 'package:our_journeys/presentation/utils/dimens.dart' as Dimens;
import 'package:our_journeys/presentation/utils/colors.dart' as OJColors;

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
      notchMargin: Dimens.standardHalfDistance,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.menu), color: Colors.white, onPressed: () {
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
                          padding: const EdgeInsets.only(top: 100.0, left: Dimens.standardQuadrupleDistance, right: Dimens.standardQuadrupleDistance),
                          child: new Text("${state.day.getFormattedDate()}", style: Typography.h4Font, maxLines: 1, overflow: TextOverflow.ellipsis),
                          height: 180,
                        ),
                      ),
                      new SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: Dimens.standardDistance),
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
    return new Container(
        margin: const EdgeInsets.symmetric(
          vertical: Dimens.standardDistance,
          horizontal: Dimens.standardDistance,
        ),
        child: new Stack(
          children: <Widget>[


            new Container(
              height: Dimens.rowHeight,
              margin: new EdgeInsets.only(left: Dimens.standardQuadrupleDistance),
              padding: new EdgeInsets.only(left: Dimens.standardQuadrupleDistance, right: Dimens.standardDistance),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.only(topRight: const Radius.circular(Dimens.standardDoubleDistance), bottomRight: const Radius.circular(Dimens.standardQuarterDistance)),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
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
                  width: Dimens.rowHeight,
                  height: Dimens.rowHeight,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: new Offset(-15.0, 0.0),
                      ),
                    ],
                  )),
            ),

            new Container(
              height: Dimens.rowHeight,
              margin: new EdgeInsets.only(left: Dimens.standardQuadrupleDistance, right: Dimens.standardDistance),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("${poi.name}", style: Typography.h6Font, maxLines: 1, overflow: TextOverflow.ellipsis),
                  new Text("${poi.address}", style: Typography.b1Font)
                ],
              ),
            )

          ],
        )
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
                    padding: EdgeInsets.symmetric(horizontal: Dimens.standardDistance),
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
    return new Container(
        height: 64.0,
        child: new Stack(
          children: <Widget>[

            _buildPoint(context, index, lastIndex),

            new Container(
              alignment: FractionalOffset.centerLeft,
              child: new Container(
                  width: Dimens.circleDimens,
                  height: Dimens.circleDimens,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: OJColors.yellow,
                  )),
            ),


            new GestureDetector(
              child: new Container(
                margin: new EdgeInsets.only(left: Dimens.standardQuadrupleDistance, right: Dimens.standardDistance),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("${day.getFormattedDate()}", style: Typography.h6Font, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _postBloc.dispatch(FetchPoi(day.index));
                _dayBloc.dispatch(FetchDays(day.index));
              },
            )


          ],
        )
    );
  }


  Widget _buildPoint(BuildContext context, int index, int lastIndex,) {
    Widget child;
    if (index == 0) {
      child = new Container(
        margin: EdgeInsets.only(top: Dimens.standardDoubleDistance, left: Dimens.standardHalfDistance),
        width: Dimens.lineWidth,
        height: Dimens.standardDoubleDistance,
        color: OJColors.purple,
      );
    } else if(index == lastIndex-1) {
      child = new Container(
        margin: EdgeInsets.only(bottom: Dimens.standardDoubleDistance, left: Dimens.standardHalfDistance),
        width: Dimens.lineWidth,
        height: Dimens.standardDoubleDistance,
        color: OJColors.purple,
      );
    } else {
      child = new Container(
        margin: EdgeInsets.only(left: Dimens.standardHalfDistance),
        width: Dimens.lineWidth,
        height: Dimens.standardQuadrupleDistance,
        color: OJColors.purple,
      );
    }
    return child;
  }


  void _showInSnackBar(context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }


}