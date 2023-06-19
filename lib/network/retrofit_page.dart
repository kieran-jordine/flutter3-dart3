import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_dart3/network/post.dart';
import 'package:flutter3_dart3/network/rest_client.dart';
import 'package:retrofit/retrofit.dart';

class RetrofitPage extends StatefulWidget {
  const RetrofitPage({super.key});

  @override
  State<RetrofitPage> createState() => _RetrofitPageState();
}

class _RetrofitPageState extends State<RetrofitPage> {
  final dio = Dio();
  late RestClient client;

  @override
  void initState() {
    super.initState();
    client = RestClient(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Retrofit + Dio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  final posts = await client.getPosts();
                  debugPrint(posts.first.toString());
                },
                child: const Text('Get Posts')
            ),
            ElevatedButton(
                onPressed: () async {
                  final post = await client.getPost(5);
                  debugPrint(post.toString());
                },
                child: const Text('Get Post')
            ),
            ElevatedButton(
                onPressed: () async {
                  final post = await client.createPost(Post(userId: 250, title: 'title', body: 'body ...'));
                  debugPrint(post.toString());
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
          ],
        ),
      ),
    );
  }
}