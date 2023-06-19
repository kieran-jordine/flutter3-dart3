import 'package:dio/dio.dart';
import 'package:flutter3_dart3/clean_arch/core/data_state.dart';
import 'package:flutter3_dart3/clean_arch/features/post/data/data_sources/remote/post_api_service.dart';
import 'package:flutter3_dart3/clean_arch/features/post/data/post_model.dart';
import 'package:flutter3_dart3/clean_arch/features/post/domain/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService _postApiService;

  PostRepositoryImpl(this._postApiService);

  @override
  Future<DataState<List<PostModel>>> getPosts() async {
    try {
      final httpResponse = await _postApiService.getPosts();
      final statusCode = httpResponse.response.statusCode;
      if (statusCode != null && statusCode >= 200 && statusCode < 300) {
        // print(httpResponse.data.first.id);
        return DataSuccess(httpResponse.data);
      }
      return DataError(DioException(
        requestOptions: httpResponse.response.requestOptions,
        response: httpResponse.response,
        message: httpResponse.response.statusMessage,
        type: DioExceptionType.badResponse,
        error: httpResponse.response.statusMessage,
      ));
    } on DioException catch (e) {
      return DataError(e);
    }
  }

}