import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int? id;
  final String? name;
  final String? email;
  final String? body;
  final int? postId;

  Comment({this.id, this.name, this.email, this.body, this.postId});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  String toString() => 'Comment[id=$id, postId=$postId, email=$email]';

}