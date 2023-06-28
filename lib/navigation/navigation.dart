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
                      builder: (context) => const MyNav1()
                  )
                );
              },
              child: const Text('Material Route')
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const MyNav1()
                    )
                  );
                },
                child: const Text('Cupertino Route')
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
