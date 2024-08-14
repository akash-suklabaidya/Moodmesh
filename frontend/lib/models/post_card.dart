import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controller/feed_post_controller.dart';
import 'package:frontend/controller/like_controller.dart';
import 'package:provider/provider.dart';
import '../services/like_service.dart';
import '../utils/constants.dart';

class PostCard extends StatefulWidget {
  final Post post;

  PostCard({required this.post});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with AutomaticKeepAliveClientMixin<PostCard> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ChangeNotifierProvider(
      create: (_) {
        try {
          return LikeController(
            likeService: LikeService(),
            isLiked: widget.post.isLiked,
            likeCount: widget.post.liked.length,
          );
        } catch (e) {
          print('Error creating LikeController: $e');
          // Handle or log error if necessary
          return LikeController(
            likeService: LikeService(),
            isLiked: false,
            likeCount: 0,
          );
        }
      },
      child: Consumer<LikeController>(
        builder: (context, controller, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.post.user.gender == "Male"
                          ? 'https://via.placeholder.com/150/00A1F1?text=M'
                          : 'https://via.placeholder.com/150/FF4081?text=F',
                    ),
                  ),
                  title: Text(
                    '${widget.post.user.firstName} ${widget.post.user.lastName}',
                  ),
                ),
                const SizedBox(height: 5),
                CachedNetworkImage(
                  imageUrl: widget.post.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400,
                  placeholder: (context, url) => Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        controller.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.isLiked ? Colors.red : Colors.grey,
                        size: 30,
                      ),
                      onPressed: () => controller.toggleLike(widget.post.id),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        'lib/assets/icons/comment.svg',
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        'lib/assets/icons/save1.svg',
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Text(
                    '${controller.likeCount} likes',
                    style: kContentTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: widget.post.comments.isNotEmpty
                      ? Text(
                          'View all ${widget.post.comments.length} comments',
                          style: const TextStyle(color: kblacklight),
                        )
                      : const SizedBox.shrink(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Text(
                    widget.post.caption ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
