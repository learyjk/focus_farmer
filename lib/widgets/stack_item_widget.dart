import 'package:flutter/material.dart';
import 'package:focus_farmer/providers/stack_item.dart';
import 'package:focus_farmer/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class StackItemWidget extends StatelessWidget {
  final StackItem item;

  StackItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    List<double> getTreeCoordinatesForFruit(StackItem item) {
      final double squareLength = screenWidth;
      final double maxRadius = squareLength / 2 * 0.6;

      // initialize with middle coord.
      final List<double> coordinates = [
        squareLength / 2,
        squareLength / 2 - squareLength * 0.15,
      ];

      final randomRadius = maxRadius * item.unitRadius;
      final randomAngle = 2 * pi * item.unitAngle;

      // print('random radius $randomRadius');
      // print('random angle $randomAngle');

      final xTrans = randomRadius * cos(randomAngle);
      final yTrans = randomRadius * sin(randomAngle);

      // print('xTrans $xTrans');
      // print('yTrans $yTrans');

      coordinates[0] = coordinates[0] + xTrans;
      coordinates[1] = coordinates[1] + yTrans;

      print(coordinates);

      return coordinates;
    }

    final List<double> coords = getTreeCoordinatesForFruit(item);

    return Positioned(
      left: coords[0],
      top: coords[1],
      child: SvgPicture.asset(
        item.assetPath,
        semanticsLabel: item.label,
        width: screenWidth * fruitScaleFactor,
        height: screenWidth * fruitScaleFactor,
      ),
    );
  }
}

// Positioned(
// left: item.xCoord,
// top: item.yCoord,
// child: Text(
// item.value,
// style: TextStyle(fontSize: fruitSize),
// ),
// );
