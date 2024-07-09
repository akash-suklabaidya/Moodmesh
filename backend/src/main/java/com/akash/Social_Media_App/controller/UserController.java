package com.akash.Social_Media_App.controller;

import java.util.List;
import java.util.Optional;

import com.akash.Social_Media_App.exceptions.UserException;
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

//    @PostMapping("/users")
//    public User createUser(@RequestBody User user) {
//
//        User savedUser=userService.registerUser(user);
//
//        return savedUser;
//    }

    @GetMapping("/api/users")
    public List<User> getUsers() {

        List<User> users = userRepository.findAll();
        return users;

    }

    @GetMapping("/api/users/{userId}")
    public User getUserById(@PathVariable Integer userId) throws UserException {

        User user=userService.findUserById(userId);
        return user;

    }

    @PutMapping("/api/users")
    public User updateUser(@RequestHeader("Authorization")String jwt,@RequestBody User user)throws Exception {
        User reqUser=userService.findUserByJwt(jwt);
        User updatedUser=userService.updateUser(user, reqUser.getId());
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
    @PutMapping("users/follow/{userId2}")
    public User followUserHandler(@RequestHeader("Authorization")String jwt,@PathVariable Integer userId2)throws UserException{

        User reqUser=userService.findUserByJwt(jwt);
        User user=userService.followUser(reqUser.getId(), userId2);
        return user;

    }
    @GetMapping("/api/users/search")
    public List<User> searchUser(@RequestParam("query")String query){
        List<User> users=userService.searchUser(query);
        return users;
    }

    @GetMapping("/api/users/profile")
    public User getUserFromToken(@RequestHeader("Authorization")String jwt){
//        System.out.println(("jwt---------"+jwt));
        User user=userService.findUserByJwt(jwt);
        user.setPassword(null);
        return user;

    }

}
