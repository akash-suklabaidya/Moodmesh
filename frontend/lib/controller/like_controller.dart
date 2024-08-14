// lib/controllers/like_controller.dart
import 'package:flutter/material.dart';
import '../services/like_service.dart';

class LikeController extends ChangeNotifier {
  final LikeService likeService;
  bool isLiked;
  int likeCount;

  LikeController({
    required this.likeService,
    required this.isLiked,
    required this.likeCount,
  });

  Future<void> toggleLike(String postId) async {
    try {
      isLiked = await likeService.toggleLike(postId, isLiked);
      likeCount = isLiked ? likeCount + 1 : likeCount - 1;
      notifyListeners();
    } catch (e) {
      print('Error toggling like: $e');
      // Optionally show an error message to the user
    }
  }
}
