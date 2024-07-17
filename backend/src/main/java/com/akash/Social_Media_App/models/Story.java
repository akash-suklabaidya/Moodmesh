package com.akash.Social_Media_App.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
@Setter
@Getter
@AllArgsConstructor
@Document(collection = "stories")
public class Story {

    @Id
    private String id;

    @DBRef
    private User user;
    private String image;
    private String captions;
    private LocalDateTime timestamp;

    public Story(){}

}
