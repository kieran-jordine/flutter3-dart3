
import 'package:flutter/material.dart';
import 'package:flutter3_dart3/state_management/providers2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Riverpod2Page extends StatelessWidget {
  const Riverpod2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Riverpod Generator'),
        ),
        body: const Consumer1(),
      ),
    );
  }
}

class Consumer1 extends ConsumerWidget {
  const Consumer1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todos1 = ref.watch(syncTodoProvider);
    final AsyncValue<List<Todo>> todos2 = ref.watch(asyncTodoProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey[100],
            child: ListView(
              children: [
                for (final todo in todos1)
                  CheckboxListTile(
                    value: todo.completed,
                    onChanged: (value) => ref.read(syncTodoProvider.notifier).toggle(todo.id),
                    title: Text(todo.title),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey[100],
            child: todos2.when(
                data: (data) => ListView(
                  children: [
                    for (final todo in data)
                      CheckboxListTile(
                        value: todo.completed,
                        onChanged: (value) => ref.read(asyncTodoProvider.notifier).toggle(todo.id),
                        title: Text(todo.title),
                      ),
                  ],
                ),
                error: (error, _) => Center(child: Text(error.toString())),
                loading: () => const CircularProgressIndicator.adaptive(),
            ),
          ),
        ],
      ),
    );
  }
}
