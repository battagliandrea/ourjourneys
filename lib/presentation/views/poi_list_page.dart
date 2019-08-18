import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist.dart';
import 'package:our_journeys/presentation/bloc/poilist/poilist_bloc.dart';
import 'package:our_journeys/presentation/model/model.dart';

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
            body: _buildListView()
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
      return new Card(
        child: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Text("$index. ${poi.name}")
        ),
      );
    }
}