class Post {
  final String id;
  final String? caption;
  final String? image; // Nullable, as not every post might have an image
  final String? video; // Nullable, as not every post might have a video
  final User user;
  final List<User> liked;
  final DateTime createdAt;
  final List<Comment> comments;
  bool isLiked;

  Post({
    required this.id,
    required this.caption,
    this.image,
    this.video,
    required this.user,
    required this.liked,
    required this.createdAt,
    required this.comments,
    this.isLiked = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      caption: json['caption'] as String?,
      image: json['image'] as String?, // Handle null
      video: json['video'] as String?, // Handle null
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      liked: (json['liked'] as List<dynamic>?)
              ?.map((item) => User.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt:
          DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now(),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((item) => Comment.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
    );
  }
}

class Comment {
  final String id;
  final String? caption;
  final User user;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.caption,
    required this.user,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      caption: json['caption'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt:
          DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now(),
    );
  }
}
