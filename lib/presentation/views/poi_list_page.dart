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
  PoiListPage({Key key, this.title }) : super(key: key);

  final String title;

  @override
  _PoiListPageState createState() => new _PoiListPageState();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//          PAGE STATE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class _PoiListPageState extends State<PoiListPage> {

  final TextStyle _H1Font = const TextStyle(color: Colors.black54, fontSize: 21.0, fontWeight: FontWeight.bold);
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
        appBar: _buildAppBar(),
        body: _buildListView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: BlocBuilder(
            bloc: _dayBloc,
            builder: (BuildContext context, DaysState state){
              if(state is DaysLoaded){
                return FloatingActionButton(
                  child: const Icon(Icons.map), onPressed: () {
                  var day = state.selectedDay;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(day: day)));
                },
                );
              }
              return new Text("Our Journey");
            }
        ),
        bottomNavigationBar: _buildBottomAppBar()
    );
  }


  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          BOTTOM APP BAR
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildAppBar() {
    return new AppBar(
        title: BlocBuilder(
            bloc: _dayBloc,
            builder: (BuildContext context, DaysState state){
              if(state is DaysLoaded){
                return new Text("${state.selectedDay.getFormattedDate()}");
              }
              return new Text("Our Journey");
            }
        )
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
          if(state is PoiUninitialized){
            return Center(
                child: CircularProgressIndicator()
            );
          }

          if(state is PoiLoaded){
            return Center(
//                child: new ListView.builder(
//                    padding: new EdgeInsets.symmetric(vertical: 16.0),
//                    itemCount: state.poi.length,
//                    itemBuilder: (BuildContext _context, int i) {
//                      return _buildRow(_context, i, state.poi[i]);
//                    }
//                )
//              child: new Expanded(
                child: new Container(
                  child: new CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: <Widget>[
                      new SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        sliver: new SliverFixedExtentList(
                          itemExtent: 152.0,
                          delegate: new SliverChildBuilderDelegate(
                                (context, index) => _buildRow(context, index, state.poi[index]),
                            childCount: state.poi.length,

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
//              )
            );
          }

          if(state is PoiError){
            return Center(
                child: Text('failed to fetch posts')
            );
          }
          return Container();
        }
    );
  }

  Widget _buildRow(context, int index, Poi poi) {
//    return new Stack(
//      children: <Widget>[
//        new Row(
//          children: <Widget>[
//            new Expanded(
//              child: new Container(
//                margin: const EdgeInsets.only(left: 16.0),
//                child: new Card(
//                  child: InkWell(
//                    onTap: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => PoiDetailPage(poi: poi)));
//                    },
//                    child: new Container(
//                      padding: new EdgeInsets.only(left:36.0, top: 24.0, bottom: 24.0, right: 24.0),
//                      child: new Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          new Text("${poi.name}", style: _H1Font, maxLines: 1, overflow: TextOverflow.ellipsis),
//                          new Text("${poi.address}", style: _B1Font)
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//        Positioned.fill(
//          child: Align(
//            alignment: Alignment.centerLeft,
//            child: _buildRoundShape(context, index),
//          ),
//        ),
//      ],
//    );
//    return new Container(
//      height: 124.0,
//      margin: new EdgeInsets.only(left: 46.0, top: 8.0, right: 16.0, bottom: 8.0,),
//      decoration: new BoxDecoration(
//        color: Colors.white,
//        shape: BoxShape.rectangle,
//        borderRadius: new BorderRadius.circular(8.0),
//        boxShadow: <BoxShadow>[
//          new BoxShadow(
//            color: Colors.black12,
//            blurRadius: 10.0,
//            offset: new Offset(0.0, 10.0),
//          ),
//        ],
//      ),
//    );

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
                    offset: new Offset(0.0, 10.0),
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
//                    boxShadow: <BoxShadow>[
//                      new BoxShadow(
//                        color: Colors.black12,
//                        blurRadius: 10.0,
//                        offset: new Offset(10.0, .0),
//                      ),
//                    ],
                  )),
            ),

            new Container(
              height: 124.0,
              margin: new EdgeInsets.only(left: 60.0, right: 16.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("${poi.name}", style: _H1Font, maxLines: 1, overflow: TextOverflow.ellipsis),
                  new Text("${poi.address}", style: _B1Font)
                ],
              ),
            )


          ],
        )
    );
  }

  Widget _buildRoundShape(context, int index){
    final TextStyle _indexFont = const TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold);
    return new Container(
      padding: const EdgeInsets.all(16.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueGrey,
      ),
      child: new Text("${++index}", style: _indexFont),
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
                if(state is DayUninitialized){
                  return Container();
                }

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

                return Container();
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
        _dayBloc.dispatch(FetchDays(day.index))
      },
    );
  }

  void _showInSnackBar(context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
}