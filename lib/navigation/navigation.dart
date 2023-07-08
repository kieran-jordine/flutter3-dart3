import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyNavigation extends StatelessWidget {
  const MyNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Navigation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyNav1(),
                  )
                );
              },
              child: const Text('Material Route'),
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const MyNav1(),
                    )
                  );
                },
                child: const Text('Cupertino Route'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/nav1');
              },
              child: const Text('Named Route'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed(
                  '/nav2/12345?name=me&age=44',
                  arguments: {'rass': 'claat'},
                );
              },
              child: const Text('Generated Route'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyNav1 extends StatelessWidget {
  const MyNav1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nav1'),
      ),
      body: const Center(
        child: Text('Nav 1'),
      ),
    );
  }
}

class MyNav2 extends StatelessWidget {
  final dynamic objectArgs;
  final dynamic pathArgs;
  const MyNav2({super.key, this.objectArgs, this.pathArgs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nav2'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(objectArgs.toString()),
            Text(pathArgs.toString()),
          ],
        ),
      ),
    );
  }
}
