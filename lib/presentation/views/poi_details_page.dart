import 'package:flutter/material.dart';

class PoiDetailsPage extends StatefulWidget {

  PoiDetailsPage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _PoiDatailsPageState createState() => new _PoiDatailsPageState();
}

class _PoiDatailsPageState extends State<PoiDetailsPage> {


    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Details Page"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ),
      );
    }
}