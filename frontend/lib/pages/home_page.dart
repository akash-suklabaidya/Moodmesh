import 'package:flutter/material.dart';
import 'package:frontend/controller/feed_post_controller.dart';
import '../services/post_service.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Feed'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts found.'));
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post: post);
            },
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
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
            subtitle: Text('@${post.user.email.split('@').first}'),
          ),
          if (post.image != null)
            Image.network(
              post.image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              post.caption,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.favorite, color: Colors.red),
                SizedBox(width: 4),
                Text('${post.liked.length} likes'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${post.comments.length} comments',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
