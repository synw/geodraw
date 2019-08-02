import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:livemap/livemap.dart';
import 'package:geodraw/geodraw.dart';
import '../types.dart';
import '../dialogs.dart';

class _LinePickerState extends State<LinePicker> {
  _LinePickerState({@required this.callback});

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
          status = const Text("Tap to add line points");
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
        controller.addLineOnTap();
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

class LinePicker extends StatefulWidget {
  LinePicker({@required this.callback});

  final AddMapAssetCallback callback;

  @override
  _LinePickerState createState() => _LinePickerState(callback: callback);
}
