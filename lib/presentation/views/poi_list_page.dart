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
import 'package:our_journeys/presentation/views/poi_detail_page.dart';

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

  final TextStyle _H4Font = const TextStyle(color: Colors.black87, fontSize: 36.0, fontWeight: FontWeight.bold);
  final TextStyle _H6Font = const TextStyle(color: Colors.black87, fontSize: 21.0, fontWeight: FontWeight.bold);

  final TextStyle _B1Font = const TextStyle(color: Colors.black54, fontSize: 12.0, fontWeight: FontWeight.normal);
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
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.menu), onPressed: () {
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
                          padding: const EdgeInsets.only(top: 100.0, left: 64.0, right: 64.0),
                          child: new Text("${state.day.getFormattedDate()}", style: _H4Font, maxLines: 1, overflow: TextOverflow.ellipsis),
                          height: 180,
                        ),
                      ),
                      new SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
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

//            return Center(
//                child:
//            );
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
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[


            new Container(
              height: 124.0,
              margin: new EdgeInsets.only(left: 60.0),
              padding: new EdgeInsets.only(left: 56.0, right: 16.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.only(topRight: const Radius.circular(36.0), bottomRight: const Radius.circular(4.0)),
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
                  width: 124.0,
                  height: 124.0,
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
              height: 124.0,
              margin: new EdgeInsets.only(left: 60.0, right: 16.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("${poi.name}", style: _H6Font, maxLines: 1, overflow: TextOverflow.ellipsis),
                  new Text("${poi.address}", style: _B1Font)
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
                      child: new ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.blueGrey,
                          ),
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0),
                          itemCount: state.days.length,
                          itemBuilder: (BuildContext _context, int i) {
                            return _buildDayRow(_context, state.days[i]);
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

  Widget _buildDayRow(context, Day day) {
    return new ListTile(
      leading: Icon(Icons.calendar_today),
      title: Text("${day.getFormattedDate()}"),
      onTap: () => {
        Navigator.pop(context),
        _postBloc.dispatch(FetchPoi(day.index)),
        //_dayBloc.dispatch(FetchDays(day.index))
      },
    );
  }

  void _showInSnackBar(context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
}