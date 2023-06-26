
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers2.g.dart';

/// generated providers autoDispose by default

/// generates a [Notifier] and [NotifierProvider]
@riverpod
class SyncTodo extends _$SyncTodo {

  // determines if this is an async-notifier
  @override
  List<Todo> build() => [
    Todo(1, 'Todo 1', false, 1),
    Todo(2, 'Todo 2', true, 1),
    Todo(3, 'Todo 3', false, 1),
    Todo(4, 'Todo 4', true, 1),
  ];

  void add(Todo todo) {
    state = [...state, todo];
  }

  void remove(int id) {
    state = [
      for (final todo in state)
        if (todo.id != id) todo,
    ];
  }

  void toggle(int id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(todo.id, todo.title, !todo.completed, todo.userId)
        else
          todo
    ];
  }

}

@Riverpod(keepAlive: false)
class AsyncTodo extends _$AsyncTodo {
  Future<List<Todo>> _fetchTodos() async {
    final response = (await dio.get<List<dynamic>>('https://jsonplaceholder.typicode.com/todos')).data;
    return response == null ? [] : response
        .map((e) => Todo(e['id'], e['title'], e['completed'], e['userId']))
        .toList();
  }

  Future<Todo> _patchTodo(int id, Map<String, dynamic> input) async {
    final e = (await dio.patch<Map<String, dynamic>>('https://jsonplaceholder.typicode.com/todos/$id', data: input)).data;
    return Todo(e?['userId'], e?['title'], e?['completed'], e?['userId']);
  }

  @override
  FutureOr<List<Todo>> build() => _fetchTodos();

  Future<void> toggle(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      bool status = state.value?.firstWhere((element) => element.id == id).completed ?? false;
      Todo updated = await _patchTodo(id, <String, dynamic>{'completed': !status});
      Todo newTodo = Todo(id, updated.title, updated.completed, updated.userId);
      int index = state.value?.indexOf(newTodo) ?? -1;
      if (index != -1) {
        final newState = [...state.value!];
        newState[index] = newTodo;
        return Future.value(newState);
      }
      return Future.value(state.value);
    });
  }
}


final fetchTodoProvider1 = FutureProviderFamily((ref, id) async {
  final response = (await dio.get<Map<String, dynamic>>('https://jsonplaceholder.typicode.com/todos/$id')).data;
  return Todo(response?['userId'], response?['title'], response?['completed'], response?['userId']);
});
final fetchTodoProvider2 = FutureProvider.autoDispose.family((ref, id) async {
  final response = (await dio.get<Map<String, dynamic>>('https://jsonplaceholder.typicode.com/todos/$id')).data;
  return Todo(response?['userId'], response?['title'], response?['completed'], response?['userId']);
});
// @riverpod
// Future<Todo> fetchTodoProvider3(FetchTodoProvider3Ref ref, {required int id}) async {
//   final response = (await dio.get<Map<String, dynamic>>('https://jsonplaceholder.typicode.com/todos/$id')).data;
//   return Todo(response?['userId'], response?['title'], response?['completed'], response?['userId']);
// }

@riverpod
String example1(Example1Ref ref) {
  return 'Riverpod';
}
@riverpod
Future<String> example2(Example2Ref ref) {
  return Future.value('Riverpod');
}
@riverpod
Stream<String> example3(Example3Ref ref) async* {
  yield 'Riverpod';
}




final dio = Dio();
class Todo {
  final int id;
  final String title;
  final bool completed;
  final int userId;

  Todo(this.id, this.title, this.completed, this.userId);

  @override
  bool operator ==(Object other) =>
    other is Todo &&
    other.runtimeType == runtimeType &&
    other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '$id, $title, $completed, $userId';
}
