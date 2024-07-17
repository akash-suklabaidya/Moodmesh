package com.akash.Social_Media_App.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "chats") // Specify the MongoDB collection name
public class Chat {

    @Id
    private String id; // Use String for id in MongoDB, or ObjectId if using BSON ObjectIds

    private String chatName;

    // List of users participating in the chat
    @DBRef
    private List<User> users = new ArrayList<>();

    private LocalDateTime timeStamp;

    // List of messages in the chat
    @JsonIgnore
    @DBRef
    private List<Message> messages = new ArrayList<>();

}
