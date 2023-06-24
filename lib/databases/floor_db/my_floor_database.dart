import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos.dart';
import 'entities.dart';

part 'my_floor_database.g.dart';

@Database(version: 1, entities: [FloorTodo])
abstract class MyFloorDatabase extends FloorDatabase {
  FloorTodoDao get floorTodoDao;
}