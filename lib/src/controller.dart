import 'dart:math';
import 'package:flutter/material.dart';
import 'package:livemap/livemap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_markers/map_markers.dart';
import 'package:latlong/latlong.dart';
import 'types.dart';

final _rng = Random();

/// The drawer controller
class GeoDrawController {
  /// Provide a [liveMapController]
  GeoDrawController(
      {@required this.liveMapController, this.nameAssets = false});

  /// The map controller
  final LiveMapController liveMapController;

  /// Use named assets
  final bool nameAssets;

  /// Map asset type to add
  MapAssetType currentMapAssetType;

  /// Current line or polygon name
  String currentMapAssetName;

  /// Current map or polygon coordinates
  var currentSerie = <LatLng>[];

  /// Current marker callback
  AddMarkerCallback currentCallback;

  /// Finish drawing a polygon or the line
  void finishDrawing({BuildContext context, AddMapAssetCallback callback}) {
    if (callback != null) {
      callback(context, currentSerie);
    }
    currentMapAssetType = null;
    currentMapAssetName = null;
    currentSerie = <LatLng>[];
  }

  /// Set map tp tap to add a marker
  void addMarkerOnTap({AddMarkerCallback callback}) {
    currentMapAssetType = MapAssetType.marker;
    if (callback != null) {
      currentCallback = callback;
    }
  }

  /// Set map tp tap to add a line
  void addLineOnTap() {
    currentMapAssetType = MapAssetType.line;
    currentSerie = <LatLng>[];
  }

  /// Set map tp tap to add a polygon
  void addPolygonOnTap() {
    currentMapAssetType = MapAssetType.polygon;
    currentSerie = <LatLng>[];
  }

  /// Add a marker on map on action
  void addMarker(
      {@required BuildContext context, @required LatLng point, String name}) {
    if (!nameAssets) {
      final n = _rng.nextInt(10000);
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

  /// Add a line on map on action
  void addPointToLine(
      {@required BuildContext context, @required LatLng point, String name}) {
    if (nameAssets) {
      if (name != null) {
        currentMapAssetName = name;
      } else {
        name = currentMapAssetName;
      }
    } else {
      final n = _rng.nextInt(10000);
      name = "marker_$n";
      currentMapAssetName = name;
    }
    if (liveMapController.namedLines.containsKey(name)) {
      liveMapController.removeLine(name);
    }
    liveMapController.addLine(name: name, points: currentSerie..add(point));
  }

  /// Add a polygon on map on action
  void addPointToPolygon(
      {@required BuildContext context, @required LatLng point, String name}) {
    if (nameAssets) {
      if (name != null) {
        currentMapAssetName = name;
      } else {
        name = currentMapAssetName;
      }
    } else {
      final n = _rng.nextInt(10000);
      name = "marker_$n";
      currentMapAssetName = name;
    }
    if (liveMapController.namedPolygons.containsKey(name)) {
      liveMapController.removePolygon(name);
    }
    liveMapController.addPolygon(name: name, points: currentSerie..add(point));
  }
}
