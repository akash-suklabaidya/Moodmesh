package com.akash.Social_Media_App.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.hibernate.boot.jaxb.mapping.LifecycleCallback;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

@Data
@AllArgsConstructor
@Entity
public class Chat {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String chat_name;
    @ManyToMany
    private List<User> users=new ArrayList<>();
    private LocalDateTime timeStamp;
    public Chat(){}

}
