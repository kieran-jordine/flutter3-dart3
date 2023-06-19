import 'package:flutter3_dart3/clean_arch/features/post/domain/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({int? id, int? userId, String? title, String? body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}