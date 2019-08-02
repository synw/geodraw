import 'package:flutter/material.dart';
import 'package:geodraw/geodraw.dart';
import 'package:latlong/latlong.dart';

class PolygonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PolygonPicker(
      callback: (BuildContext context, List<LatLng> points) {
        print("Polygon;");
        for (final point in points) {
          print("$point");
        }
        //Navigator.of(context).pop();
      },
    );
  }
}
