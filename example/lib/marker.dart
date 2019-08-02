import 'package:flutter/material.dart';
import 'package:geodraw/geodraw.dart';
import 'package:latlong/latlong.dart';

class MarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MarkerPicker(
      callback: (BuildContext context, LatLng point) {
        print("POINT: $point");
        Navigator.of(context).pop();
      },
    );
  }
}
