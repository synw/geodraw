import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:livemap/livemap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_markers/map_markers.dart';
import 'package:latlong/latlong.dart';
import 'types.dart';

final rng = Random();

class GeoDrawController {
  GeoDrawController(
      {@required this.liveMapController, this.nameAssets = false});

  final LiveMapController liveMapController;
  final bool nameAssets;

  MapAssetType currentMapAssetType;
  String currentMapAssetName;
  var currentSerie = <LatLng>[];
  AddMarkerCallback currentCallback;

  void finishDrawing({BuildContext context, AddMapAssetCallback callback}) {
    if (callback != null) {
      callback(context, currentSerie);
    }
    currentMapAssetType = null;
    currentMapAssetName = null;
    currentSerie = <LatLng>[];
  }

  void addMarkerOnTap({AddMarkerCallback callback}) {
    currentMapAssetType = MapAssetType.marker;
    if (callback != null) {
      currentCallback = callback;
    }
  }

  void addLineOnTap() {
    currentMapAssetType = MapAssetType.line;
    currentSerie = <LatLng>[];
  }

  void addPolygonOnTap() {
    currentMapAssetType = MapAssetType.polygon;
    currentSerie = <LatLng>[];
  }

  void addMarker(
      {@required BuildContext context, @required LatLng point, String name}) {
    if (!nameAssets) {
      int n = rng.nextInt(10000);
      name = "marker_$n";
    }
    liveMapController.addMarker(
        name: name,
        marker: Marker(
            height: 100.0,
            width: 80.0,
            point: point,
            builder: (context) => BubbleMarker(
                  bubbleColor: Colors.green,
                  bubbleContentWidgetBuilder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          liveMapController.removeMarker(name: name),
                    );
                  },
                )));
    if (currentCallback != null) {
      currentCallback(context, point);
    }
    currentMapAssetType = null;
  }

  void addPointToLine(
      {@required BuildContext context, @required LatLng point, String name}) {
    if (nameAssets) {
      if (name != null) {
        currentMapAssetName = name;
      } else {
        name = currentMapAssetName;
      }
    } else {
      int n = rng.nextInt(10000);
      name = "marker_$n";
      currentMapAssetName = name;
    }
    if (liveMapController.namedLines.containsKey(name)) {
      liveMapController.removeLine(name);
    }
    liveMapController.addLine(name: name, points: currentSerie..add(point));
  }

  void addPointToPolygon(
      {@required BuildContext context, @required LatLng point, String name}) {
    if (nameAssets) {
      if (name != null) {
        currentMapAssetName = name;
      } else {
        name = currentMapAssetName;
      }
    } else {
      int n = rng.nextInt(10000);
      name = "marker_$n";
      currentMapAssetName = name;
    }
    if (liveMapController.namedPolygons.containsKey(name)) {
      liveMapController.removePolygon(name);
    }
    liveMapController.addPolygon(name: name, points: currentSerie..add(point));
  }
}
