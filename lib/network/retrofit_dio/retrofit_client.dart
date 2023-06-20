import 'package:dio/dio.dart' hide Headers;
import 'package:flutter3_dart3/network/entities/post.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

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

  @GET('does-not-exist')
  Future<Post> error();

  @GET('does-not-exist')
  Future<HttpResponse<Post>> errorWithHttpResponse();

}