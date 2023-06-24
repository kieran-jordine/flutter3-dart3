import 'package:floor/floor.dart';

@entity
class FloorTodo {
  @primaryKey
  final int id;
  final String title;
  final bool completed;
  final int userId;

  FloorTodo(this.id, this.title, this.completed, this.userId);

  @override
  String toString() =>
      'FloorTodo(id=$id, title=$title, completed=$completed, userId=$userId)';
}

@Entity(tableName: 'Category')
class FloorCategory {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String description;
  @ColumnInfo(name: 'created')
  final DateTime createdAt;

  FloorCategory(this.id, this.description, this.createdAt);
}
