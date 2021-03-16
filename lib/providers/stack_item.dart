import 'package:flutter/cupertino.dart';

class StackItem {
  int id;
  String assetPath;
  String label;
  double unitRadius;
  double unitAngle;
  String dateTime;

  StackItem(
      {this.id,
      @required this.assetPath,
      @required this.label,
      @required this.unitRadius,
      @required this.unitAngle,
      @required this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'assetPath': assetPath,
      'label': label,
      'unitRadius': unitRadius,
      'unitAngle': unitAngle,
      'dateTime': dateTime,
    };
  }

  StackItem.fromMap(Map<String, Object> map) {
    id = map['id'];
    assetPath = map['assetPath'];
    label = map['label'];
    unitRadius = map['unitRadius'];
    unitAngle = map['unitAngle'];
    dateTime = map['dateTime'];
  }
}
