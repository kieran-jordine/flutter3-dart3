import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_dart3/clean_arch/core/data_state.dart';
import 'package:flutter3_dart3/clean_arch/features/post/data/data_sources/remote/post_api_service.dart';
import 'package:flutter3_dart3/clean_arch/features/post/data/post_repository_impl.dart';

class NetworkCallsPage extends StatefulWidget {
  const NetworkCallsPage({super.key});

  @override
  State<NetworkCallsPage> createState() => _NetworkCallsPageState();
}

class _NetworkCallsPageState extends State<NetworkCallsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  final dio = Dio();
                  final api = PostApiService(dio);
                  final impl = PostRepositoryImpl(api);
                  final res = await impl.getPosts();
                  if (res is DataSuccess) {
                    debugPrint('DATA SUCCESS');
                  }
                  if (res is DataError) {
                    debugPrint('DATA ERROR');
                  }
                  if (res.data != null) {
                    debugPrint('ID of first: ${res.data?.first.id}');
                  }
                },
                child: const Text('Get Posts')
            ),
          ],
        ),
      ),
    );
  }

}
