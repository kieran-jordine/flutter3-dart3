import 'package:dio/dio.dart' hide Headers;
import 'package:flutter3_dart3/network/post.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('posts')
  Future<List<Post>> getPosts();

  @GET('posts/{id}')
  Future<Post> getPost(@Path("id") int id);

  @POST('posts')
  Future<Post> createPost(@Body() Post post);

  @PUT('posts/{id}')
  Future<Post> updatePost(@Path() int id, @Body() Post post);

  @PATCH('posts/{id}')
  Future<Post> updatePostPart(@Path() int id, @Body() Map<String, dynamic> post);

  @DELETE('posts/{id}')
  Future<dynamic> deletePost(@Path() int id);

  @GET('posts/{id}')
  Future<HttpResponse<Post>> getPostWithHttpResponse(@Path("id") int id);

  @GET('posts/{id}')
  @Headers(<String, dynamic>{'X-Custom': 'Header'})
  Future<HttpResponse<Post>> getPostWithHeader(@Path("id") int id);
}