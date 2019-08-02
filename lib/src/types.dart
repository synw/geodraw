import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';

enum MapAssetType { marker, line, polygon }

typedef void AddMarkerCallback(BuildContext context, LatLng point);

typedef void AddMapAssetCallback(BuildContext context, List<LatLng> points);
