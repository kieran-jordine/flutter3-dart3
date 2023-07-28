import 'package:flutter/material.dart';
import 'package:flutter3_dart3/config/routes.dart';
import 'package:flutter3_dart3/navigation/navigation.dart';

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
      debugShowCheckedModeBanner: false,
      routes: namedRoutes,
      // initialRoute: '/',
      onGenerateRoute: generatedRoute,
      home: const MyNavigation(), // const MyHomePage(title: 'Flutter Concepts'),

      // onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => const UnknownRoute()),
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
  
  final items = ['Apple', 'Banana', 'Carrot'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text('Network Call'),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RetrofitPage()));
            },
          ),
          // RawAutocomplete(
          //   optionsViewBuilder: (context, AutocompleteOnSelected<String> onSelected, options) {
          //     return Align(
          //       alignment: Alignment.topCenter,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Material(
          //           elevation: 4.0,
          //           child: SizedBox(
          //             height: 200.0,
          //             child: ListView.builder(
          //               padding: const EdgeInsets.all(8.0),
          //               itemCount: items.length,
          //               itemBuilder: (context, index) {
          //                 return GestureDetector(
          //                   onTap: () => onSelected(items[index]),
          //                   child: ListTile(
          //                     title: Text(items[index]),
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          //   optionsBuilder: (textEditingValue) {
          //     return items.where((element) => element.toLowerCase().contains(textEditingValue.text.toLowerCase()));
          //   },
          //   fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: TextFormField(
          //         controller: textEditingController,
          //         focusNode: focusNode,
          //         onFieldSubmitted: (value) {
          //           onFieldSubmitted();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
