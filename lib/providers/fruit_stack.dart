import 'package:flutter/cupertino.dart';
import 'package:focus_farmer/providers/stack_item.dart';

class FruitStack with ChangeNotifier {
  List<StackItem> _fruitStack = [
    // StackItem(
    //     id: '1',
    //     label: 'Apple',
    //     assetPath: 'assets/images/fruits/apple.svg',
    //     distFromLeft: 0.00,
    //     distFromTop: 0.00,
    //     dateTime: DateTime.now()),
    // StackItem(
    //     id: '2',
    //     label: 'Apricot',
    //     assetPath: 'assets/images/fruits/apricot.svg',
    //     distFromLeft: 1.1,
    //     distFromTop: 1.1,
    //     dateTime: DateTime.now()),
    // StackItem(
    //     id: '3',
    //     label: 'Banana',
    //     assetPath: 'assets/images/fruits/bananas.svg',
    //     distFromLeft: 0.27,
    //     distFromTop: 0.19,
    //     dateTime: DateTime.now())
  ];

  FruitStack();

  List<StackItem> get fruitStack {
    return [..._fruitStack];
  }

  void addStackItem(StackItem item) {
    _fruitStack.add(item);
    notifyListeners();
  }
}
