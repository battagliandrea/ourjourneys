import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist_bloc.dart';
import 'package:our_journeys/presentation/model/model.dart';
import 'package:our_journeys/presentation/views/poi_details_page.dart';

class PoiListPage extends StatefulWidget {

  PoiListPage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _PoiListPageState createState() => new _PoiListPageState();
}

class _PoiListPageState extends State<PoiListPage> {

    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
    final PoiBloc _postBloc = PoiBloc();

    @override
    void initState() {
        super.initState();
        _postBloc.dispatch(Fetch());
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

    Widget _buildListView() {
        return BlocBuilder(
            bloc: _postBloc,
            builder: (BuildContext context, PoiState state){
                if(state is PoiUninitialized){
                    return new Center(
                        child: CircularProgressIndicator()
                    );
                }

                if(state is PoiLoaded){
                    return new Center(
                            child: new ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: state.poi.length,
                            itemBuilder: (BuildContext _context, int i) {
                                return _buildRow(i, state.poi[i]);
                            }
                        )
                    );
                }

                if(state is PoiError){
                    return new Center(
                        child: Text('failed to fetch posts')
                    );
                }
            }
        );
    }

    Widget _buildRow(int index, Poi poi) {
//        return new ListTile(
//            title: new Text(
//                "$index. ${poi.name}",
//                style: _biggerFont,
//            )
//        );
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
                new Text("${poi.lat} - ${poi.long}")
              ],
            ),
          ),
        ),
      );
    }

    void _settingModalBottomSheet(context){
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc){
            return Container(
              padding: EdgeInsets.only(bottom: 64.0),
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    title: new Text('Day 1'),
                    onTap: () => {}
                  ),
                  new ListTile(
                    title: new Text('Day 2'),
                    onTap: () => {},
                  ),
                  new ListTile(
                    title: new Text('Day 3'),
                    onTap: () => {},
                  ),
                  new ListTile(
                    title: new Text('Day 4'),
                    onTap: () => {},
                  ),
                  new ListTile(
                    title: new Text('Day 5'),
                    onTap: () => {},
                  ),
                ],
              ),
            );
          }
      );
    }
}