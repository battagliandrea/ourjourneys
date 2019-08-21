import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:our_journeys/presentation/bloc/daylist/daylist.dart';
import 'package:our_journeys/presentation/bloc/daylist/daylist_bloc.dart';
import 'package:our_journeys/presentation/bloc/daylist/daylist_state.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist_bloc.dart';
import 'package:our_journeys/presentation/model/model.dart';
import 'package:our_journeys/presentation/views/poi_details_page.dart';

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

    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
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
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.menu), onPressed: () {
                _settingModalBottomSheet(context);
              },),
            ],
          ),
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
                              return _buildRow(_context, state.poi[i]);
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

    Widget _buildRow(context, Poi poi) {
      return new GestureDetector(
        onTap: () => {
          Navigator.push( context, MaterialPageRoute(builder: (context) => PoiDetailsPage()))
        },
        child: new Card(
          child: new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Column(
              children: <Widget>[
                new Text("${poi.name}", style: _biggerFont),
                new Text("${poi.address}"),
                new Text("${poi.lat} - ${poi.lon}")
              ],
            ),
          ),
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
          title: Text("${new DateFormat("dd MMM").format(day.date)}", style: _biggerFont),
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