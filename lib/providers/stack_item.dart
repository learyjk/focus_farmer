import 'package:flutter/cupertino.dart';

class StackItem {
  final String id;
  final String assetPath;
  final Object label;
  final double unitRadius;
  final double unitAngle;
  final DateTime dateTime;

  StackItem(
      {@required this.id,
      @required this.assetPath,
      @required this.label,
      @required this.unitRadius,
      @required this.unitAngle,
      @required this.dateTime});
}
