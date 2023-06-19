import 'package:flutter3_dart3/clean_arch/core/data_state.dart';
import 'package:flutter3_dart3/clean_arch/features/post/domain/post_entity.dart';

abstract class PostRepository {
  Future<DataState<List<PostEntity>>> getPosts();
}