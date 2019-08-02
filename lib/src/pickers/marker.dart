import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:livemap/livemap.dart';
import 'package:geodraw/geodraw.dart';
import '../types.dart';

class _MarkerPickerState extends State<MarkerPicker> {
  _MarkerPickerState({@required this.callback});

  final AddMarkerCallback callback;

  LiveMapController liveMapController;
  GeoDrawController controller;
  FloatingActionButton fab;
  FloatingActionButton basefab;
  StreamSubscription _changefeed;

  @override
  void initState() {
    liveMapController = LiveMapController(mapController: MapController());
    controller = GeoDrawController(liveMapController: liveMapController);
    basefab = FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        controller.addMarkerOnTap(callback: callback);
        setState(() => fab = FloatingActionButton(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.touch_app, color: Colors.red),
              onPressed: () => null,
            ));
      },
    );
    fab = basefab;
    liveMapController.onReady.then((_) {
      _changefeed = liveMapController.changeFeed.listen((change) {
        if (change.name == "updateMarkers") {
          resetFab();
        }
      });
    });
    super.initState();
  }

  void resetFab() {
    setState(() => fab = basefab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrawerMap(controller: controller),
      floatingActionButton: fab,
    );
  }

  @override
  void dispose() {
    liveMapController.dispose();
    _changefeed.cancel();
    super.dispose();
  }
}

class MarkerPicker extends StatefulWidget {
  MarkerPicker({@required this.callback});

  final AddMarkerCallback callback;

  @override
  _MarkerPickerState createState() => _MarkerPickerState(callback: callback);
}
