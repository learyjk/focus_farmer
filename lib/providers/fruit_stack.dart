import 'package:flutter/cupertino.dart';
import 'package:focus_farmer/providers/stack_item.dart';

class FruitStack with ChangeNotifier {
  List<StackItem> _fruitStack = [
    StackItem(
        id: '1',
        value: '🍎',
        xCoord: 135,
        yCoord: 227,
        dateTime: DateTime.now()),
    StackItem(
        id: '2',
        value: '🍑',
        xCoord: 140,
        yCoord: 200,
        dateTime: DateTime.now()),
    StackItem(
        id: '3',
        value: '🍌',
        xCoord: 120,
        yCoord: 250,
        dateTime: DateTime.now())
  ];

  FruitStack();

  List<StackItem> get fruitStack {
    return [..._fruitStack];
  }
}
