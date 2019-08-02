import 'package:flutter/material.dart';
import 'package:geodraw/geodraw.dart';
import 'package:latlong/latlong.dart';

class LinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinePicker(
      callback: (BuildContext context, List<LatLng> points) {
        print("Line;");
        for (final point in points) {
          print("$point");
        }
        //Navigator.of(context).pop();
      },
    );
  }
}
