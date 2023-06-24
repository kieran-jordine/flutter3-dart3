import 'package:flutter/material.dart';
import 'package:flutter3_dart3/databases/database_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DatabasePage(), // MyHomePage(title: 'Flutter Concepts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NetworkCallsPage()));
            //   },
            //   child: const Text('Clean Architecture')
            // ),
            ElevatedButton(
              child: const Text('Network Call'),
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RetrofitPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
