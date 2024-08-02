import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/controller/feed_post_controller.dart';

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Add spacing between cards
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.user.gender == "Male"
                  ? 'https://via.placeholder.com/150/00A1F1?text=M' // Male Placeholder
                  : 'https://via.placeholder.com/150/FF4081?text=F'), // Female Placeholder
            ),
            title: Text('${post.user.firstName} ${post.user.lastName}'),
            // subtitle: Text('@${post.user.email.split('@').first}'),
          ),
          const SizedBox(
            height: 5,
          ),
          if (post.image != null)
            Image.network(
              post.image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 400,
            ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    ),
                    SizedBox(width: 4),
                    // Text('${post.liked.length} likes'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(
                  'lib/assets/icons/comment.svg',
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                // child: Text(
                //   '${post.comments.length} comments',
                //   style: TextStyle(color: Colors.grey),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),

                child: SvgPicture.asset(
                  'lib/assets/icons/save1.svg',
                  width: MediaQuery.of(context).size.width * 0.06,
                  height: 30,
                ),
                // Text('${post.liked.length} likes'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              post.caption,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
