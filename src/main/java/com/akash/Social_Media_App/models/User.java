package com.akash.Social_Media_App.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor

@Entity
public class User {

    @Id
    private Integer id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private List<Integer> followers=new ArrayList<>();
    private List<Integer> followings=new ArrayList<>();
    private String gender;

    public User() {

    }

}
