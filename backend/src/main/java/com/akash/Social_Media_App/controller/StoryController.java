package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.models.Story;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.services.StoryService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class StoryController {
    @Autowired
    private StoryService storyService;
    @Autowired
    private UserService userService;

    @PostMapping("/api/story")
    public ResponseEntity<?> createStory(@RequestBody Story story, @RequestHeader("Authorization") String jwt) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            Story createdStory = storyService.createStory(story, reqUser);
            return new ResponseEntity<>(createdStory, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/api/story/user/{userId}")
    public ResponseEntity<?> findUsersStory(@PathVariable String userId, @RequestHeader("Authorization") String jwt) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            List<Story> stories = storyService.findStoryByUserId(userId);
            return new ResponseEntity<>(stories, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
}
