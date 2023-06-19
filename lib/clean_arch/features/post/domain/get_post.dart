import 'package:flutter3_dart3/clean_arch/core/data_state.dart';
import 'package:flutter3_dart3/clean_arch/core/usecase.dart';
import 'package:flutter3_dart3/clean_arch/features/post/domain/post_entity.dart';
import 'package:flutter3_dart3/clean_arch/features/post/domain/post_repository.dart';

class GetPostsUseCase implements UseCase<DataState<List<PostEntity>>, void> {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<DataState<List<PostEntity>>> call({void params}) {
    return _postRepository.getPosts();
  }
  
}