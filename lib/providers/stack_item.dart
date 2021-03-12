import 'package:flutter/cupertino.dart';

class StackItem {
  final String id;
  final Object value;
  final double xCoord;
  final double yCoord;
  final DateTime dateTime;

  StackItem(
      {@required this.id,
      @required this.value,
      @required this.xCoord,
      @required this.yCoord,
      @required this.dateTime});
}
