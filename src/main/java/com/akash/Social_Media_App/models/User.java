package com.akash.Social_Media_App.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

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

    public User() {

    }

}
