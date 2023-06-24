
import 'package:flutter/material.dart';
import 'package:flutter3_dart3/databases/drift_db/schema.dart';
import 'package:flutter3_dart3/databases/floor_db/entities.dart';
import 'package:flutter3_dart3/databases/floor_db/my_floor_database.dart';
import 'package:flutter3_dart3/databases/hive_db/schema.dart';
import 'package:hive/hive.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {

  final driftDb = MyDriftDatabase();
  late MyFloorDatabase floorDb;
  late Box<HiveTodo> hiveDb;

  @override
  void initState() {
    super.initState();
    $FloorMyFloorDatabase.databaseBuilder('floor_db.db').build()
      .then((value) => floorDb = value);
    initHive()
      .then((value) {
        Hive.openBox<HiveTodo>('hiveBox')
            .then((value) => hiveDb = value);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Databases'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  try {
                    // insert
                    // DriftTodoData insert1 = const DriftTodoData(
                    //   id: 100,
                    //   title: 'title',
                    //   completed: true,
                    //   userId: 2
                    // );
                    DriftTodoCompanion insert2 = DriftTodoCompanion.insert(
                      title: 'title',
                      completed: true,
                      userId: 2
                    );
                    await driftDb
                        .into(driftDb.driftTodo)
                        .insert(insert2);
                    await driftDb
                      .into(driftDb.categories)
                      .insert(CategoriesCompanion.insert(description: 'description'));

                    // select
                    // final List<DriftTodoData> todos = await driftDb
                    //   .select(driftDb.driftTodo)
                    //   .get();
                    // debugPrint(todos.toString());
                    // final query = driftDb.select(driftDb.driftTodo)
                    //   ..where((tbl) => tbl.completed);
                    // final completed = await query.get();
                    // print(completed.toString());
                    // var map = todos.elementAt(0).toJson();
                    // print(map);
                    // var todo = DriftTodoData.fromJson(map);
                    // print(todo);

                    final List<Category> cats = await driftDb.select(driftDb.categories).get();
                    print(cats);
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Drift'),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final todo = FloorTodo(1, 'floor title', false, 2);
                    final todoDao = floorDb.floorTodoDao;
                    // delete
                    await todoDao.deleteTodo(todo);

                    // insert
                    await todoDao.createTodo(todo);
                    print(await todoDao.findAll1());

                    // update
                    await todoDao.updateTodo(FloorTodo(1, 'floor title', true, 2));

                    print(await todoDao.findAll1());

                    todoDao.findAll2().listen((event) { print('stream $event'); });
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Floor'),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final todo = HiveTodo(1, 'title', false, 2);
                    final indx = await hiveDb.add(todo);
                    debugPrint('${hiveDb.getAt(indx)}');
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Hive'),
            ),
          ],
        ),
      ),
    );
  }

}
