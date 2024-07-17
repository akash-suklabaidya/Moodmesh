package com.akash.Social_Media_App.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "comments") // Specify the MongoDB collection name
public class Comment {

    @Id
    private String id; // Use String for id in MongoDB, or ObjectId if using BSON ObjectIds

    private String content;

    // Reference to the User document (Author of the comment)
    @DBRef
    private User user;

    // List of users who liked this comment
    @DBRef
    private List<User> liked = new ArrayList<>();

    private LocalDateTime createdAt;

}
