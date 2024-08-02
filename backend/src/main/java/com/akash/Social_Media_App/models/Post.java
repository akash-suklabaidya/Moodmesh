package com.akash.Social_Media_App.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@Document(collection = "posts") // Specify the MongoDB collection name
public class Post {

    @Id
    private String id; // Use String for id in MongoDB, or ObjectId if using BSON ObjectIds

    private String caption;
    private String image;
    private String video;

    // Reference to the User document (Author of the post)
    @DBRef
    private User user;

    // References to User documents (Users who liked the post)
    @DBRef
    private List<User> liked = new ArrayList<>();

    private LocalDateTime createdAt;

    // References to Comment documents (Comments on the post)
    @DBRef
    private List<Comment> comments = new ArrayList<>();


    // Default constructor (needed for MongoDB)
    public Post() {
    }
}
