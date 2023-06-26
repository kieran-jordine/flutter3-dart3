import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider: creates/exposes a value; cache and performant
// StateProvider: simple logic; exposes a value
// FutureProvider:
// StreamProvider:
// StateNotifierProvider: manipulate advanced states, works with [StateNotifier]
// .autoDispose: make provider automatically destroy when state is out-of-scope
// .family: enable external parameters

final helloProvider = Provider((ref) => 'Riverpod');
final countProvider1 = StateNotifierProvider<Counter1, int>((ref) => Counter1(ref));
class Counter1 extends StateNotifier<int> {
  //have access to a ref
  final Ref ref;
  Counter1(this.ref): super(0);

  void increment() {
    state++;
  }
}
final countProvider2 = StateProvider((ref) => 0);

final filterProvider = StateProvider<Filter>((_) => Filter.completed);
final todoFilter = StateNotifierProvider<TodoList, List<Todo>>((ref) => TodoList());
final filteredTodoProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(filterProvider);
  final todos = ref.watch(todoFilter);
  return switch (filter) {
    Filter.completed => todos.where((element) => element.completed).toList(),
    Filter.uncompleted => todos.where((element) => !element.completed).toList(),
    _ => todos,
  };
});
class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? todos]) : super(todos ?? []);

  void add(Todo todo) {
    state = [
      ...state,
      todo
    ];
  }

  void remove(Todo todo) {
    state = state.where((element) => element.id != todo.id).toList();
  }

  void addRandom(bool completed) {
    final count = state.length + 1;
    state = [
      ...state,
      Todo(count, 'title $count', completed, count)
    ];
  }

}
class Todo {
  final int id;
  final String title;
  final bool completed;
  final int userId;

  Todo(this.id, this.title, this.completed, this.userId);

  @override
  String toString() => '$title => $completed';
}
enum Filter {
  none, completed, uncompleted
}

final userProvider = StreamProvider<User>((ref) => Stream.periodic(const Duration(seconds: 2), (count) => User('User $count', 0)).take(10));
class User {
  final String name;
  final int age;

  User(this.name, this.age);

  @override
  String toString() => name;
}

final dio = Dio();
final searchProvider = StateProvider((ref) => 1, name: 'searchProvider');
final todoFutureProvider1 = FutureProvider.autoDispose<Todo?>((ref) async {
  final search = ref.watch(searchProvider);
  final cancelToken = CancelToken();
  ref.onDispose(() { cancelToken.cancel(); });
  final response = (await dio.get<Map<String, dynamic>>(
      'https://jsonplaceholder.typicode.com/todos/$search',
      cancelToken: cancelToken
    )).data;
  ref.keepAlive();
  return Todo(response?['userId'], response?['title'], response?['completed'], response?['userId']);
});
final todoFutureProvider2 = FutureProvider.autoDispose.family((ref, id) async {
  final response = (await dio.get<Map<String, dynamic>>('https://jsonplaceholder.typicode.com/todos/$id')).data;
  return Todo(response?['userId'], response?['title'], response?['completed'], response?['userId']);
});


class Observer extends ProviderObserver {
  @override
  void didUpdateProvider(provider, previousValue, newValue, container) {
    print('${provider.name} => $newValue');
  }
}

