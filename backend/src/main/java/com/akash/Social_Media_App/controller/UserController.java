package com.akash.Social_Media_App.controller;

import java.util.List;
import java.util.Optional;

import com.akash.Social_Media_App.exceptions.UserException;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.repository.UserRepository;

@RestController
@RequestMapping("/api/users") // Add base mapping for all endpoints in this controller
public class UserController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserService userService;

    @GetMapping
    public ResponseEntity<List<User>> getUsers() {
        List<User> users = userRepository.findAll();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getUserById(@PathVariable String userId) {
        try {
            User user = userService.findUserById(userId);
            return new ResponseEntity<>(user, HttpStatus.OK);
        } catch (UserException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping
    public ResponseEntity<?> updateUser(@RequestHeader("Authorization") String jwt, @RequestBody User user) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            User updatedUser = userService.updateUser(user, reqUser.getId());
            return new ResponseEntity<>(updatedUser, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/{userId}")
    public ResponseEntity<?> deleteUser(@PathVariable String userId) {
        Optional<User> user = userRepository.findById(userId);
        if (user.isEmpty()) {
            return new ResponseEntity<>("User not exist with id " + userId, HttpStatus.NOT_FOUND);
        }

        userRepository.delete(user.get());
        return new ResponseEntity<>("User deleted successfully with id " + userId, HttpStatus.OK);
    }

    @PutMapping("/follow/{userId2}")
    public ResponseEntity<?> followUserHandler(@RequestHeader("Authorization") String jwt, @PathVariable String userId2) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            User user = userService.followUser(reqUser.getId(), userId2);
            if (user == null) {
                return new ResponseEntity<>("Unable to follow user with id " + userId2, HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<>(user, HttpStatus.OK);
        } catch (UserException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/search")
    public ResponseEntity<?> searchUser(@RequestParam("query") String query) {
        try {
            List<User> users = userService.searchUser(query);
            return new ResponseEntity<>(users, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/profile")
    public ResponseEntity<?> getUserFromToken(@RequestHeader("Authorization") String jwt) {
        try {
            User user = userService.findUserByJwt(jwt);
            user.setPassword(null);
            return new ResponseEntity<>(user, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

}
