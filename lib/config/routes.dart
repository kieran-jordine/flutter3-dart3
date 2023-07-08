import 'package:flutter/material.dart';
import 'package:flutter3_dart3/navigation/navigation.dart';

final Map<String, Widget Function(BuildContext context)> namedRoutes = {
  // '/': (context) => const MyNav1(), /// same as home property
  '/nav1': (context) => const MyNav1(),
};

Route<dynamic> generatedRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');
  final Object? args = settings.arguments;
  if (settings.name?.startsWith('/nav2') ?? false) {
    return MaterialPageRoute(builder: (context) => MyNav2(
        objectArgs: args,
        pathArgs: {'param':uri.pathSegments[1], 'query': uri.queryParameters},
      ),
    );
  }
  return MaterialPageRoute(builder: (context) => const UnknownRoute());
}

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Unknown Route', style: Theme.of(context).textTheme.headlineSmall,),
              FilledButton(onPressed: () {Navigator.pop(context);}, child: const Text('Back')),
            ],
          ),
        ),
      ),
    );
  }
}