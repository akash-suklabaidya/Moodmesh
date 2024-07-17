package com.akash.Social_Media_App.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "messages") // Specify the MongoDB collection name
public class Message {

    @Id
    private String id; // Use String for id in MongoDB, or ObjectId if using BSON ObjectIds

    private String content;
    private String image;

    // Reference to the User document (Author of the message)
    @DBRef
    private User user;

    // Reference to the Chat document
    @DBRef
    private Chat chat;

    private LocalDateTime timestamp;

}
