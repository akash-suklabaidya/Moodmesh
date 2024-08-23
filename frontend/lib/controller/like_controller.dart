import 'package:flutter/material.dart';
import 'package:frontend/services/like_service.dart';

class LikeController extends ChangeNotifier {
  final LikeService _likeService = LikeService();
  bool isLiked = false;
  Map<String, dynamic>? postData;

  Future<void> toggleLike(String postId) async {
    print(postId);
    try {
      postData = await _likeService.likePost(postId);
      print(postData);
      isLiked = postData!['liked'].length > 0;
      notifyListeners();
    } catch (e) {
      print('Error liking post: $e');
    }
  }
}
