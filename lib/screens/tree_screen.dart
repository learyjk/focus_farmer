import 'package:flutter/material.dart';
import 'dart:math';
import 'package:focus_farmer/providers/fruit_stack.dart';
import 'package:focus_farmer/widgets/app_drawer.dart';
import 'package:focus_farmer/widgets/stack_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_farmer/providers/stack_item.dart';

class TreeScreen extends StatefulWidget {
  static const String routeName = '/tree-screen';

  @override
  _TreeScreenState createState() => _TreeScreenState();
}

class _TreeScreenState extends State<TreeScreen> {
  // List generateRandomPosition() {
  //   final squareLength = MediaQuery.of(context).size.width;
  //   final maxRadius = squareLength / 2 * 0.6;
  //   var rand = Random();
  //
  //   final origin = [
  //     squareLength / 2,
  //     squareLength / 2 - squareLength * 0.15,
  //   ];
  //
  //   final randomRadius = maxRadius * rand.nextDouble();
  //   final randomAngle = 2 * pi * rand.nextDouble();
  //
  //   // print('random radius $randomRadius');
  //   // print('random angle $randomAngle');
  //
  //   final xTrans = randomRadius * cos(randomAngle);
  //   final yTrans = randomRadius * sin(randomAngle);
  //
  //   // print('xTrans $xTrans');
  //   // print('yTrans $yTrans');
  //
  //   origin[0] = origin[0] + xTrans;
  //   origin[1] = origin[1] + yTrans;
  //
  //   // print(origin);
  //
  //   return origin;
  // }

  // function to test plotting of fruit on the tree
  // void testFruitPlot(List<Widget> myList) {
  //   for (int i = 0; i < 100; i++) {
  //     final pos = generateRandomPosition();
  //
  //     final newItem = StackItem(
  //         id: '1',
  //         assetPath: 'assets/images/fruits/apple.svg',
  //         label: 'Apple',
  //         unitRadius: pos[0],
  //         unitAngle: pos[1],
  //         dateTime: DateTime.now());
  //     myList.add(StackItemWidget(newItem));
  //   }
  // }

  List<Widget> generateTreeAndItemsList() {
    List<Widget> stackList = [];
    final Widget treeSvg = SvgPicture.asset(
      'assets/images/tree.svg',
      semanticsLabel: 'Productivity Tree',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
    );

    stackList.add(treeSvg);

    // Add the fruit
    var fruitToAdd = Provider.of<FruitStack>(context).fruitStack;

    fruitToAdd.map((item) {
      stackList.add(StackItemWidget(item));
    }).toList();

    // testFruitPlot(stackList);

    return stackList;
  }

  @override
  Widget build(BuildContext context) {
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
        child: FittedBox(
          child: Stack(
            children: stackList,
          ),
          //fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter,
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
