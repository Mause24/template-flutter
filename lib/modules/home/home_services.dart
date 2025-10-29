import 'package:dio/dio.dart';
import 'package:template_flutter/globals/models/modules/posts_models.dart';

final dio = Dio();

Future<Post> getTodo(int id) async {
  final response = await dio.get(
    "https://jsonplaceholder.typicode.com/todos/$id",
  );
  return Post.fromJson(response.data);
}

Future<List<Post>?> getTodos() async {
  final response = await dio.get<List<dynamic>>(
    "https://jsonplaceholder.typicode.com/posts",
  );
  print(response.data.toString());
  return response.data?.map((post) => Post.fromJson(post)).toList();
}
