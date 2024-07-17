package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.models.Reels;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.services.ReelsService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ReelsController {

    @Autowired
    private ReelsService reelsService;
    @Autowired
    private UserService userService;

    @PostMapping("/api/reels")
    public ResponseEntity<?> createReels(@RequestBody Reels reel, @RequestHeader("Authorization") String jwt) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            Reels createdReels = reelsService.createReels(reel, reqUser);
            return new ResponseEntity<>(createdReels, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/api/reels")
    public ResponseEntity<?> findAllReels() {
        try {
            List<Reels> reels = reelsService.findAllReels();
            return new ResponseEntity<>(reels, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/api/reels/user/{userId}")
    public ResponseEntity<?> findUserReels(@PathVariable String userId) {
        try {
            List<Reels> reels = reelsService.findUsersReels(userId);
            return new ResponseEntity<>(reels, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
}
