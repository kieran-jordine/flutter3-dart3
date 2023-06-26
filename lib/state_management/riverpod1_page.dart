import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter3_dart3/state_management/providers1.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Riverpod1Page extends StatelessWidget {
  const Riverpod1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [Observer()],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Riverpod'),
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
    final hello = ref.watch(helloProvider);
    final counter1 = ref.watch(countProvider1);
    final counter2 = ref.watch(countProvider2);
    final todo1 = ref.watch(filteredTodoProvider);
    final user = ref.watch(userProvider);
    final todo2 = ref.watch(todoFutureProvider1);
    final todo3 = ref.watch(todoFutureProvider2(1));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          ElevatedButton(
            onPressed: null, // () {},
            child: Text('Provider 1 => $hello'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(countProvider1.notifier).increment();
            },
            child: Text('Provider 2 => $counter1'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(countProvider2.notifier).update((state) => ++state);
            },
            child: Text('Provider 3 => $counter2'),
          ),
          ElevatedButton(
            onPressed: () {
              bool completed = Random().nextBool();
              ref.read(todoFilter.notifier).addRandom(completed);
            },
            child: Text('Provider 4 => ${todo1.length}'),
          ),
          ElevatedButton(
            onPressed: null, // () {},
            child: user.when(
              data: (data) => Text('Provider 5 => $data'),
              error: (error, _) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(searchProvider.notifier).state++;
            },
            child: todo2.when(
              data: (data) => Text('Provider 6 => $data'),
              error: (error, _) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
          ),
          ElevatedButton(
            onPressed: null,
            child: todo3.when(
              data: (data) => Text('Provider 6 => $data'),
              error: (error, _) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator.adaptive(),
            ),
          ),
        ],
      ),
    );
  }

}
