import 'package:flutter/material.dart';
import 'package:frontend/controller/feed_post_controller.dart';
import 'package:frontend/models/post_card.dart';
import 'package:frontend/utils/constants.dart';
import '../services/post_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = PostService().getFeedPosts();
  }

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Moodmesh',
          style: kAppTitle.copyWith(
            fontSize: kAppTitle.fontSize! * textScaleFactor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}\n${snapshot.stackTrace}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[posts.length - index - 1];
              print(
                  'Rendering post: ${post.id}, ${post.caption}, ${post.image}, ${post.video}');
              return PostCard(post: post);
            },
          );
        },
      ),
    );
  }
}
