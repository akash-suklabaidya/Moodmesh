package com.akash.Social_Media_App.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor

@Entity
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String caption;
    private String image;
    private String video;

    //One user multiple post
    @ManyToOne
    private User user;

    //One post can be liked by many user
    @OneToMany
    private List<User> liked=new ArrayList<>();
    private LocalDateTime createdAt;


    public Post() {

    }
}
