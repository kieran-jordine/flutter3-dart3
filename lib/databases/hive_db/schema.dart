import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'schema.g.dart';

@HiveType(typeId: 1)
class HiveTodo extends HiveObject  {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool completed;
  @HiveField(3)
  final int userId;

  HiveTodo(this.id, this.title, this.completed, this.userId);
  
  @override
  String toString() => title;
}

Future<void> initHive() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(HiveTodoAdapter());
}