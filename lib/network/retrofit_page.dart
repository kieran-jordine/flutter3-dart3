
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_dart3/network/core/network_state.dart';
import 'package:flutter3_dart3/network/entities/post.dart';
import 'package:flutter3_dart3/network/retrofit_dio/dio_config.dart';
import 'package:flutter3_dart3/network/retrofit_dio/retrofit_client.dart';
import 'package:retrofit/retrofit.dart';

class RetrofitPage extends StatefulWidget {
  const RetrofitPage({super.key});

  @override
  State<RetrofitPage> createState() => _RetrofitPageState();
}

class _RetrofitPageState extends State<RetrofitPage> {
  late RetrofitClient client;

  @override
  void initState() {
    super.initState();
    configure();
    client = RetrofitClient(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Networking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  final posts = await client.getPosts();
                  debugPrint(posts.first.toString());
                  // getPosts();
                },
                child: const Text('Get Posts')
            ),
            ElevatedButton(
                onPressed: () async {
                  final post = await client.getPost(5);
                  debugPrint(post.toString());
                  // getPost();
                },
                child: const Text('Get Post')
            ),
            ElevatedButton(
                onPressed: () async {
                  var post = Post(userId: 250, title: 'title (created)', body: 'body ...');
                  final posted = await client.createPost(post);
                  debugPrint(posted.toString());
                  // createPost();
                },
                child: const Text('Create Post')
            ),
            ElevatedButton(
                onPressed: () async {
                  final post = await client.updatePost(1, Post(userId: 250, title: 'title', body: 'body ...'));
                  debugPrint(post.toString());
                },
                child: const Text('Update Post')
            ),
            ElevatedButton(
                onPressed: () async {
                  final post = await client.updatePostPart(1, {'title': 'title'});
                  debugPrint(post.toString());
                },
                child: const Text('Patch Post')
            ),
            ElevatedButton(
                onPressed: () async {
                  await client.deletePost(1);
                  debugPrint('DELETED');
                },
                child: const Text('Delete Post')
            ),
            ElevatedButton(
                onPressed: () async {
                  final HttpResponse<Post> httpResponse = await client.getPostWithHttpResponse(5);
                  final post1 = httpResponse.data;
                  final res = httpResponse.response.data; // is a Map
                  final post2 = Post.fromJson(res);
                  debugPrint(post1.toString());
                  debugPrint(res);
                  debugPrint(post2.toString());
                  debugPrint(httpResponse.response.statusCode.toString());
                  debugPrint(httpResponse.response.statusMessage);
                  debugPrint(httpResponse.response.extra.toString());
                  debugPrint(httpResponse.response.requestOptions.method);
                  debugPrint(httpResponse.response.isRedirect.toString());
                  debugPrint(httpResponse.response.redirects.toString());
                  // debugPrint(httpResponse.response.headers);
                },
                child: const Text('HttpResponse')
            ),
            ElevatedButton(
                onPressed: () async {
                  final HttpResponse<Post> httpResponse = await client.getPostWithHeader(5);
                  debugPrint(httpResponse.response.headers.toString());
                },
                child: const Text('Headers')
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await client.error();
                  } on DioException catch (e) {
                    debugPrint(e.message);
                    debugPrint(e.type.toString());
                    debugPrint(e.response?.statusCode.toString());
                    debugPrint(e.response?.statusMessage.toString());
                  }
                },
                child: const Text('Error Post')
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await client.errorWithHttpResponse();
                  } on DioException catch (e) {
                    debugPrint(e.message);
                  }
                },
                child: const Text('Error HttpResponse')
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final comment = await client.getComment();
                    debugPrint(comment.toString());
                  } on DioException catch (e) {
                    debugPrint(e.message);
                    debugPrint(e.type.toString());
                    debugPrint(e.response?.statusCode.toString());
                    debugPrint(e.response?.statusMessage.toString());
                  }
                },
                child: const Text('Get Comment')
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final user = await client.getUser();
                    debugPrint(user.toString());
                  } on DioException catch (e) {
                    debugPrint(e.message);
                    debugPrint(e.type.toString());
                    debugPrint(e.response?.statusCode.toString());
                    debugPrint(e.response?.statusMessage.toString());
                  } on AssertionError catch (e) {
                    debugPrint(e.message?.toString());
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Get User')
            ),ElevatedButton(
                onPressed: () async {
                  try {
                    NetworkState ns = Loaded(false);
                    debugPrint(what(ns));
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Sealed')
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    // const res = ApiResponse<String>.data("generic string");
                    // print(res);
                  } on AssertionError catch (e) {
                    debugPrint(e.message?.toString());
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Generic')
            ),
          ],
        ),
      ),
    );
  }

  String what(NetworkState networkState) {
    return switch(networkState) {
      Initial() => 'initial',
      Loading() => 'loading',
      Loaded() => 'loaded',
      Success() => 'success',
      Error() => 'error'
    };
  }
}
