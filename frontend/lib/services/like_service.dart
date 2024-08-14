// lib/services/like_service.dart
import 'package:http/http.dart' as http;

class LikeService {


  Future<bool> toggleLike(String postId, bool isLiked) async {
    final url = 'https://moodmesh.onrender.com/api/posts/like/$postId';
    try {
      final response = await http.put(Uri.parse(url));

      if (response.statusCode == 200) {
        return !isLiked; // Toggle the like status
      } else {
        throw Exception('Failed to toggle like status');
      }
    } catch (e) {
      throw Exception('Error occurred while toggling like status: $e');
    }
  }
}
