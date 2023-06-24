
import 'package:floor/floor.dart';
import 'package:flutter3_dart3/databases/floor_db/entities.dart';

@dao
abstract class FloorTodoDao {
  @Query('SELECT * FROM FloorTodo')
  Future<List<FloorTodo>> findAll1();

  @Query('SELECT * FROM FloorTodo')
  Stream<List<FloorTodo>> findAll2();

  @Query('SELECT * FROM FloorTodo WHERE id = :id')
  Stream<FloorTodo?> findById(int id);

  @insert
  Future<void> createTodo(FloorTodo todo);

  @update
  Future<int> updateTodo(FloorTodo todo);

  @delete
  Future<void> deleteTodo(FloorTodo todo);
}
