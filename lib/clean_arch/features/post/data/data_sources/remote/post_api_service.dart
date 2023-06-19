import 'package:dio/dio.dart';
import 'package:flutter3_dart3/clean_arch/features/post/data/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'post_api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class PostApiService {
  factory PostApiService(Dio dio) = _PostApiService;

  @GET('posts')
  Future<HttpResponse<List<PostModel>>> getPosts();

}