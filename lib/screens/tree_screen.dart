import 'package:flutter/material.dart';
import 'package:focus_farmer/constants.dart';
import 'package:focus_farmer/providers/stack_item.dart';
import 'dart:math';
import 'package:focus_farmer/providers/fruit_stack.dart';
import 'package:focus_farmer/widgets/app_drawer.dart';
import 'package:focus_farmer/widgets/stack_item_widget.dart';
import 'package:provider/provider.dart';

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

  List<Widget> generateTreeAndItemsList() {
    List<Widget> stackList = [];

    var time = DateTime.now();
    //var firstCoord = generateRandomPosition(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.width)

    // Add the tree
    stackList.add(
      RichText(
        text: TextSpan(
          text: '',
          children: [
            TextSpan(
              text: '🌳',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width),
            ),
          ],
        ),
      ),
    );

    // Add the fruit
    var fruitToAdd = Provider.of<FruitStack>(context).fruitStack;

    fruitToAdd.map((item) {
      stackList.add(StackItemWidget(item));
    }).toList();

    return stackList;
  }

  @override
  Widget build(BuildContext context) {
    double treeSize = MediaQuery.of(context).size.width;
    double fruitSize = MediaQuery.of(context).size.width * 0.05;
    var coord = generateRandomPosition(fruitSize, treeSize);
    List<Widget> stackList = generateTreeAndItemsList();

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
              children: stackList,
            ),
          ],
        ),
      ),
    );
  }
}

// [
// Positioned(
// left: (MediaQuery.of(context).size.width / 2),
// top: treeSize / 2,
// child: RichText(
// text: TextSpan(
// text: '',
// children: [
// TextSpan(
// text: '🍐',
// style: TextStyle(fontSize: fruitSize),
// ),
// ],
// ),
// ),
// ),
// ]
