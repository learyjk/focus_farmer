import 'package:flutter/cupertino.dart';
import 'package:focus_farmer/providers/stack_item.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String dbName = 'productivity_tree.db';
final String table = 'fruit_stack';
final String columnId = '_id';
final String columnAssetPath = 'assetPath';
final String columnLabel = 'label';
final String columnUnitRadius = 'unitRadius';
final String columnUnitAngle = 'unitAngle';
final String columnDateTime = 'dateTime';

class FruitStack with ChangeNotifier {
  //List<StackItem> _fruitStack = [
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
  //];
  FruitStack._();
  static final FruitStack db = FruitStack._();

  Database _database;

  FruitStack();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnAssetPath TEXT, $columnLabel TEXT, $columnUnitRadius REAL, $columnUnitAngle REAL, $columnDateTime TEXT)",
        );
      },
    );
    print('called open() database');

    return _database;
  }

  Future<StackItem> addStackItem(StackItem item) async {
    //_fruitStack.add(item);
    final db = await database;
    item.id = await db.insert(table, item.toMap());
    //notifyListeners();
    return item;
  }

  Future<List<StackItem>> getStackItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    List<StackItem> stackItemList = [];

    maps.forEach((map) {
      StackItem item = StackItem.fromMap(map);
      stackItemList.add(item);
    });
    //notifyListeners();
    return stackItemList;
  }
}
