package com.akash.Social_Media_App.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
// import org.springframework.web.bind.annotation.ResponseBody;

import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.repository.UserRepository;

@RestController

public class UserController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserService userService;

    @PostMapping("/users")
    public User createUser(@RequestBody User user) {

        User savedUser=userService.registerUser(user);

        return savedUser;
    }

    @GetMapping("/users")
    public List<User> getUsers() {

        List<User> users = userRepository.findAll();
        return users;

    }

    @GetMapping("/users/{userId}")
    public User getUserById(@PathVariable Integer userId) throws Exception {

        User user=userService.findUserByd(userId);
        return user;

    }

    @PutMapping("/users/{userId}")
    public User updateUser(@RequestBody User user, @PathVariable Integer userId)throws Exception {
        
        User updatedUser=userService.updateUser(user,userId);
        return updatedUser;
    }

    @DeleteMapping("/users/{userId}")
    public String deleteUser(@PathVariable Integer userId) throws Exception {

        Optional<User> user=userRepository.findById(userId);
        if(user.isEmpty()){
            throw new Exception("User not exit with id "+userId);
        }

        userRepository.delete(user.get());

        return "User deleted successfully with id+ "+userId;

    }
    @PutMapping("/users/follow/{userId1}/{userId2}")
    public User followUserHandler(@PathVariable Integer userId1,@PathVariable Integer userId2)throws Exception{

        User user=userService.followUser(userId1,userId2);
        return user;

    }
    @GetMapping("/users/search")
    public List<User> searchUser(@RequestParam("query")String query){
        List<User> users=userService.searchUser(query);
        return users;
    }



}
