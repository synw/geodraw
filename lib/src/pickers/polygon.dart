import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:livemap/livemap.dart';
import 'package:geodraw/geodraw.dart';
import '../types.dart';

class _PolygonPickerState extends State<PolygonPicker> {
  _PolygonPickerState({@required this.callback});

  final AddMapAssetCallback callback;

  LiveMapController liveMapController;
  GeoDrawController controller;
  Widget status = const Text("");
  FloatingActionButton fab;
  FloatingActionButton basefab;

  @override
  void initState() {
    liveMapController = LiveMapController(mapController: MapController());
    controller = GeoDrawController(liveMapController: liveMapController);
    basefab = FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        setState(() {
          status = const Text("Tap to add polygon points");
          fab = FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              controller.finishDrawing(context: context, callback: callback);
              resetFab();
              setState(() => status = const Text(""));
            },
          );
        });
        controller.addPolygonOnTap();
      },
    );
    fab = basefab;
    super.initState();
  }

  void resetFab() => setState(() => fab = basefab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        DrawerMap(controller: controller),
        Positioned(child: status, bottom: 25.0, left: 15.0)
      ]),
      floatingActionButton: fab,
    );
  }

  @override
  void dispose() {
    liveMapController.dispose();
    super.dispose();
  }
}

/// A polygon picker
class PolygonPicker extends StatefulWidget {
  /// The callback is optional
  PolygonPicker({@required this.callback});

  /// The callback will run after the polygon is added
  final AddMapAssetCallback callback;

  @override
  _PolygonPickerState createState() => _PolygonPickerState(callback: callback);
}
