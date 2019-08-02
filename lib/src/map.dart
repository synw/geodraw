import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geodraw/src/types.dart';
import 'package:livemap/livemap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'controller.dart';
import 'dialogs.dart';

class _DrawerMapState extends State<DrawerMap> {
  _DrawerMapState(
      {@required this.controller,
      this.titleLayer,
      this.center,
      this.zoom = 16.0})
      : assert(controller != null) {
    if (titleLayer == null) {
      titleLayer = TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']);
    }
  }

  final LatLng center;
  final double zoom;
  TileLayerOptions titleLayer;
  final GeoDrawController controller;

  LiveMapController _liveMapController;

  StreamSubscription _changefeed;

  @override
  void initState() {
    _liveMapController = controller.liveMapController;
    _liveMapController.onReady.then((_) {
      _changefeed = _liveMapController.changeFeed.listen((change) {
        if (change.name == "updateMarkers" ||
            change.name == "updateLines" ||
            change.name == "updatePolygons") {
          setState(() {});
        }
      });
      if (center == null) {
        _liveMapController.centerOnLiveMarker();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _changefeed.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LiveMap(
      mapController: _liveMapController.mapController,
      liveMapController: _liveMapController,
      mapOptions: MapOptions(
          center: center,
          zoom: zoom,
          onTap: (point) {
            if (controller.currentMapAssetType != null) {
              switch (controller.currentMapAssetType) {
                case MapAssetType.marker:
                  if (controller.nameAssets) {
                    selectAssetNameDialog(context, controller, "Marker",
                        point: point);
                  } else {
                    controller.addMarker(context: context, point: point);
                  }
                  break;
                case MapAssetType.line:
                  controller.addPointToLine(context: context, point: point);
                  break;
                case MapAssetType.polygon:
                  controller.addPointToPolygon(context: context, point: point);

                  break;
              }
            }
          }),
      titleLayer: titleLayer,
    );
  }
}

/// The main map widget
class DrawerMap extends StatefulWidget {
  /// If [center] is not provided it will auto center on current position
  DrawerMap(
      {@required this.controller,
      this.titleLayer,
      this.center,
      this.zoom = 16.0});

  /// The Flutter Map [TileLayer]
  final TileLayerOptions titleLayer;
  final GeoDrawController controller;
  final LatLng center;
  final double zoom;

  @override
  _DrawerMapState createState() => _DrawerMapState(
      controller: controller,
      titleLayer: titleLayer,
      center: center,
      zoom: zoom);
}
