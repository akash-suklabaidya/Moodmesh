import 'dart:convert';
import 'package:frontend/controller/feed_post_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostService {
  final String apiUrl = 'https://moodmesh.onrender.com/api/users/feed';

  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<List<Post>> getFeedPosts() async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        throw Exception('No auth token found');
      }
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = jsonDecode(response.body);

        // Log the fetched JSON data

        // Convert the parsed JSON data into a list of Post objects
        final List<Post> posts = jsonData.map((data) {
          try {
            // Log individual post data before parsing
            return Post.fromJson(data as Map<String, dynamic>);
          } catch (e) {
            // Log the error and the specific post data that caused it
            throw Exception('Failed to parse post: $e');
          }
        }).toList();

        return posts;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception with a meaningful message
        throw Exception(
            'Failed to load posts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any other errors and throw an exception with the error message
      throw Exception('Error fetching posts: $e');
    }
  }
}
