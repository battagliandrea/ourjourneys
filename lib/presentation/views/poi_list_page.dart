import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:our_journeys/presentation/bloc/daylist/daylist.dart';
import 'package:our_journeys/presentation/bloc/daylist/daylist_bloc.dart';
import 'package:our_journeys/presentation/bloc/daylist/daylist_state.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist_bloc.dart';
import 'package:our_journeys/presentation/model/model.dart';
import 'package:our_journeys/presentation/views/map_page.dart';

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//          PAGE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class PoiListPage extends StatefulWidget {
  PoiListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PoiListPageState createState() => new _PoiListPageState();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//          PAGE STATE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class _PoiListPageState extends State<PoiListPage> {

  final TextStyle _H1Font = const TextStyle(color: Colors.black87, fontSize: 21.0, fontWeight: FontWeight.bold);
  final TextStyle _B1Font = const TextStyle(color: Colors.black38, fontSize: 14.0, fontWeight: FontWeight.bold);

  final PoiBloc _postBloc = PoiBloc();
  final DayBloc _dayBloc = DayBloc();

  @override
  void initState() {
    super.initState();
    _postBloc.dispatch(FetchPost(0));
    _dayBloc.dispatch(FetchDays());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: _buildListView(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.map), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()),);
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
          if(state is PoiUninitialized){
            return Center(
                child: CircularProgressIndicator()
            );
          }

          if(state is PoiLoaded){
            return Center(
                child: new ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: state.poi.length,
                    itemBuilder: (BuildContext _context, int i) {
                      return _buildRow(_context, i, state.poi[i]);
                    }
                )
            );
          }

          if(state is PoiError){
            return Center(
                child: Text('failed to fetch posts')
            );
          }
        }
    );
  }

  Widget _buildRow(context, int index, Poi poi) {

    int _flexFactorIcon= 2;
    int _flexFactorCard = 8;

    return new Stack(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: new Card(
                  child: new Container(
                    padding: new EdgeInsets.only(left:36.0, top: 24.0, bottom: 24.0, right: 24.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text("${poi.name}", style: _H1Font, maxLines: 1, overflow: TextOverflow.ellipsis),
                        new Text("${poi.address}", style: _B1Font)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildRoundShape(context, index),
          ),
        ),
      ],
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
              builder: (BuildContext context, DayState state){
                if(state is DayUninitialized){
                  return Container();
                }

                if(state is DayLoaded){
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
              }
          );
        }
    );
  }

  Widget _buildDayRow(context, Day day) {
    return new ListTile(
      leading: Icon(Icons.calendar_today),
      title: Text("${new DateFormat("dd MMM").format(day.date)}"),
      onTap: () => {
        Navigator.pop(context),
        _postBloc.dispatch(FetchPost(day.index))
      },
    );
  }

  void _showInSnackBar(context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
}