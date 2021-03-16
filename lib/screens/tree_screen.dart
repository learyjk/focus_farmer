import 'package:flutter/material.dart';
import 'package:focus_farmer/providers/fruit_stack.dart';
import 'package:focus_farmer/widgets/app_drawer.dart';
import 'package:focus_farmer/widgets/stack_item_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TreeScreen extends StatefulWidget {
  static const String routeName = '/tree-screen';

  @override
  _TreeScreenState createState() => _TreeScreenState();
}

class _TreeScreenState extends State<TreeScreen> {
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

  Future<List<Widget>> generateTreeAndItemsList() async {
    List<Widget> stackList = [];

    // Adds the tree
    final Widget treeSvg = SvgPicture.asset(
      'assets/images/tree.svg',
      semanticsLabel: 'Productivity Tree',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
    );
    stackList.add(treeSvg);

    await FruitStack.db.getStackItems().then((fruitsToAdd) {
      fruitsToAdd.forEach((stackItem) {
        stackList.add(StackItemWidget(stackItem));
      });
    });
    return stackList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: generateTreeAndItemsList(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Your Tree',
                style: Theme.of(context).textTheme.headline3,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: null,
                )
              ],
            ),
            drawer: AppDrawer(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: Stack(
                  children: snapshot.data,
                ),
                alignment: Alignment.bottomCenter,
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
