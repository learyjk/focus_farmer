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

  Future<void> _areYouSure() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure?',
            style: Theme.of(context).textTheme.headline3,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You will lose all of your hard-earned fruit!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text('Never Mind'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    TextButton(
                      child: Text(
                        'Clear it!',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        _clearTree();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _clearTree() {
    FruitStack.db.deleteStack();
    setState(() {});
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
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  onSelected: (selectedValue) {
                    _areYouSure();
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Clear Tree'),
                      value: 'Clear',
                    ),
                  ],
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
