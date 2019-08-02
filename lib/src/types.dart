import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';

/// The map assets type addable
enum MapAssetType {
  /// A marker asset
  marker,

  /// A line asset
  line,

  /// A polygon asset
  polygon
}

/// The callback after adding a marker
typedef void AddMarkerCallback(BuildContext context, LatLng point);

/// The callback after adding a line or a polygon
typedef void AddMapAssetCallback(BuildContext context, List<LatLng> points);
