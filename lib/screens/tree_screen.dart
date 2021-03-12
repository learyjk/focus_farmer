import 'package:flutter/material.dart';
import 'package:focus_farmer/constants.dart';
import 'dart:math';

import 'package:focus_farmer/widgets/app_drawer.dart';

class TreeScreen extends StatefulWidget {
  static const String routeName = '/tree-screen';

  @override
  _TreeScreenState createState() => _TreeScreenState();
}

class _TreeScreenState extends State<TreeScreen> {
  generateRandomPosition(double itemSize, double treeSize) {
    double radius = (MediaQuery.of(context).size.width / 2) - (3 * itemSize);
    double midTreeH = treeSize / 2;
    double midTreeW = (MediaQuery.of(context).size.width / 2);

    var rand = Random();
    var t = 2 * pi * rand.nextDouble(); //random angle
    var u = rand.nextDouble() * radius;

    var xCoord = midTreeW + u * cos(t);
    var yCoord = midTreeH + u * sin(t);

    print('x: $xCoord');
    print('y: $yCoord');
    return [xCoord, yCoord];
  }

  @override
  Widget build(BuildContext context) {
    double treeSize = MediaQuery.of(context).size.width;
    double fruitSize = MediaQuery.of(context).size.width * 0.05;
    var coord = generateRandomPosition(fruitSize, treeSize);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Tree',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                RichText(
                  text: TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                        text: '🌳',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: coord[0],
                  top: coord[1],
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: '🍎',
                          style: TextStyle(fontSize: fruitSize),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width / 2),
                  top: treeSize / 2,
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: '🍐',
                          style: TextStyle(fontSize: fruitSize),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
