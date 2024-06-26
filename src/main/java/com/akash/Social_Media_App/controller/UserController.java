package com.akash.Social_Media_App.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
// import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.repository.UserRepository;

@RestController

public class UserController {

    @Autowired
    UserRepository userRepository;

    @PostMapping("/users")
    public User createUser(@RequestBody User user) {

        User newUser = new User();
        newUser.setEmail(user.getEmail());
        newUser.setFirstName(user.getFirstName());
        newUser.setLastName(user.getLastName());
        newUser.setPassword(user.getPassword());
        newUser.setId(user.getId());

        User savedUser = userRepository.save(newUser);

        return savedUser;
    }

    @GetMapping("/users")
    public List<User> getUsers() {

        List<User> users = userRepository.findAll();
        return users;

    }

    @GetMapping("/users/{userId}")
    public User getUserById(@PathVariable("userId") Integer id) {

        User user1 = new User(1, "code", "zosh", "Akash@gmail.com", "45678");

        user1.setId(id);

        return user1;

    }

    @PutMapping("/users")
    public User updateUser(@RequestBody User user) {
        User user1 = new User(1, "code", "zosh", "Akash@gmail.com", "Akash@1234");

        if (user.getFirstName() != null) {
            user1.setFirstName(user.getFirstName());
        }
        if (user.getLastName() != null) {
            user1.setLastName(user.getLastName());
        }
        if (user.getEmail() != null) {
            user1.setEmail(user.getEmail());
        }

        return user1;
    }

    @DeleteMapping("/users/{userId}")
    public String deleteUser(@PathVariable Integer userId) {
        return "User Deleted Successfully with Id " + userId;
    }

}
