import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LikeService {
  final String baseUrl = "https://moodmesh.onrender.com/api/posts/like/";

  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<Map<String, dynamic>> likePost(String postId) async {
    final url = Uri.parse("$baseUrl$postId");

    final token = await _getAuthToken();

    if (token == null) {
      throw Exception("No auth token found");
    }

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          // 'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to like post');
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
