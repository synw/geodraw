import 'package:flutter/material.dart';
import 'marker.dart';
import 'line.dart';
import 'polygon.dart';

final routes = {
  '/marker': (BuildContext context) => MarkerPage(),
  '/line': (BuildContext context) => LinePage(),
  '/polygon': (BuildContext context) => PolygonPage(),
};

class GeoDrawPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: const Text("Draw marker"),
                onPressed: () => Navigator.of(context).pushNamed("/marker"),
              ),
              RaisedButton(
                child: const Text("Draw line"),
                onPressed: () => Navigator.of(context).pushNamed("/line"),
              ),
              RaisedButton(
                child: const Text("Draw polygon"),
                onPressed: () => Navigator.of(context).pushNamed("/polygon"),
              ),
            ]),
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GeoDraw Demo',
      routes: routes,
      home: GeoDrawPage(),
    );
  }
}
