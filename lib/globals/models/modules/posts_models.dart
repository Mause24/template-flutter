import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter/globals/models/globals.dart';

part 'posts_models.g.dart';

@JsonSerializable()
class Post extends BaseModel {
  int userId;
  int id;
  String title;
  String? body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
