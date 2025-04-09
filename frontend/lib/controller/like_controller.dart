import 'package:flutter/material.dart';
import 'package:frontend/services/like_service.dart';

class LikeController with ChangeNotifier {
  bool _isLiked = false;
  Map<String, dynamic>? _postData;

  bool get isLiked => _isLiked;
  Map<String, dynamic>? get postData => _postData;

  void setInitialLikeStatus(bool isLiked) {
    _isLiked = isLiked;
    notifyListeners();
  }

  Future<void> toggleLike(String postId) async {
    try {
      final likeService = LikeService();
      _postData = await likeService.likePost(postId);
      _isLiked = !_isLiked; // Toggle the like status
      notifyListeners(); // Notify listeners to rebuild the UI
    } catch (e) {
      print("Error toggling like: $e");
    }
  }
}
