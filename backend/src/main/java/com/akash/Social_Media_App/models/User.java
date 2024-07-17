package com.akash.Social_Media_App.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.DBRef;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@Document(collection = "users")
public class User {

    @Id
    private String id; // Use String for id in MongoDB, or ObjectId if using BSON ObjectIds

    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private List<String> followers = new ArrayList<>();
    private List<String> followings = new ArrayList<>();
    private String gender;

    @JsonIgnore
    @DBRef // Establishes a MongoDB Reference to the Post collection
    private List<Post> savedPosts = new ArrayList<>();

    // Default constructor (needed for MongoDB)
    public User() {
    }
}
