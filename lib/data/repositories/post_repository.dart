import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:social_network/data/models/posts/post_model.dart';
import 'package:social_network/domain/repositories/post_repository.dart'
    as domain;

class PostRepository implements domain.PostRepository {
  final baseUrl = 'http://192.168.1.167.:5151/api/Posts';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String accessTokenKey = "access_token";

  @override
  Future<List<PostModel>> getAllPost(int page, int limit) async {
    final accessToken = await secureStorage.read(key: accessTokenKey);

    final response = await http.get(
      Uri.parse('$baseUrl?Page=$page&Limit=$limit'),
      headers: {"accept": "*/*", "Authorization": "Bearer $accessToken"},
    );

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<PostModel> posts =
            (data['data'] as List)
                .map((json) => PostModel.fromJson(json))
                .toList();
        return posts;
      } else {
        throw Exception("Failed to load posts");
      }
    } catch (e) {
      throw Exception("error: $e");
    }
  }
  //   @override
  // Future<List<PostModel>> getAllPost(int page, int limit) async {
  //   try {
  //     final accessToken = await secureStorage.read(key: accessTokenKey);

  //     final response = await http.get(
  //       Uri.parse('http://192.168.1.167:5151/api/Posts?Page=1&Limit=5'),
  //       headers: {
  //         "accept": "*/*",
  //         "Authorization": "Bearer $accessToken",
  //       },
  //     );

  //     print("API Response Status Code: ${response.statusCode}");
  //     print("API Response Body: ${response.body}");

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);

  //       if (data == null || !data.containsKey('data')) {
  //         throw Exception("Invalid API response format");
  //       }

  //       List<PostModel> posts = (data['data'] as List)
  //           .map((json) => PostModel.fromJson(json))
  //           .toList();
  //       return posts;
  //     } else {
  //       throw Exception("Failed to load posts: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error fetching posts: $e");
  //     throw Exception("Something went wrong - $e");
  //   }
  // }

}
