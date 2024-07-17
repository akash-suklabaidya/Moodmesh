package com.akash.Social_Media_App.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Getter
@Setter
@AllArgsConstructor
@Document(collection = "reels") // Specify the MongoDB collection name
public class Reels {

    @Id
    private String id; // Use String for id in MongoDB, or ObjectId if using BSON ObjectIds

    private String title;
    private String video;

    @DBRef // Reference to the User document
    private User user;

    // Default constructor (needed for MongoDB)
    public Reels() {
    }
}
