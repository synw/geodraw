import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'controller.dart';
import 'types.dart';

void selectAssetNameDialog(
    BuildContext context, GeoDrawController controller, String label,
    {LatLng point}) {
  final textController = TextEditingController();
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("$label name"),
        content: TextField(
          controller: textController,
          autofocus: true,
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text("Save"),
            onPressed: () {
              Navigator.of(context).pop();
              switch (controller.currentMapAssetType) {
                case MapAssetType.marker:
                  controller.addMarker(
                      context: context,
                      point: point,
                      name: textController.text);
                  break;
                default:
              }
            },
          ),
        ],
      );
    },
  );
}
