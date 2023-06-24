
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'schema.g.dart';

class DriftTodo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get completed => boolean()();
  IntColumn get userId => integer()();
}

@DataClassName('Category')
class Categories extends Table {
  TextColumn get id => text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get description => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'drift_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [DriftTodo, Categories])
class MyDriftDatabase extends _$MyDriftDatabase {
  MyDriftDatabase(): super(_openConnection());

  // increase when tables are added or changed
  @override
  int get schemaVersion => 1;

  Future<List<Category>> get allCategories => select(categories).get();

  Future<List<DriftTodoData>> get allTodos => select(driftTodo).get();

  Stream<List<DriftTodoData>> watchTodos(bool completed) {
    return (select(driftTodo)..where((tbl) => tbl.completed)).watch();
  }

  Stream<DriftTodoData> watchTodo(int id) {
    return (select(driftTodo)..where((tbl) => tbl.id.equals(id))).watchSingle();
  }

 }
