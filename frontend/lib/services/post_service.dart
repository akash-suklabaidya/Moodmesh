import 'dart:convert';
import 'package:frontend/utils/constants.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String apiUrl = 'http://${IP}:${PORT}/api/users/feed';

  Future<List<Post>> getFeedPosts() async {
    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Post> posts = jsonData.map((data) => Post.fromJson(data)).toList();
        return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class Post {
  final String id;
  final String caption;
  final int likesCount;

  Post({required this.id, required this.caption, required this.likesCount});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      caption: json['caption'],
      likesCount: json['likesCount'],
    );
  }
}
