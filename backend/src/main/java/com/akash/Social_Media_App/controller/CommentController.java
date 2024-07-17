package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.models.Comment;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.services.CommentService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class CommentController {

    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;

    @PostMapping("/api/comments/post/{postId}")
    public ResponseEntity<?> createComment(@RequestBody Comment comment,
                                           @RequestHeader("Authorization") String jwt, @PathVariable String postId) {
        try {
            User user = userService.findUserByJwt(jwt);
            Comment createdComment = commentService.createComment(comment, postId, user.getId());
            return new ResponseEntity<>(createdComment, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping("/api/comments/like/{commentId}")
    public ResponseEntity<?> likeComment(@RequestHeader("Authorization") String jwt, @PathVariable String commentId) {
        try {
            User user = userService.findUserByJwt(jwt);
            Comment likedComment = commentService.likeComment(commentId, String.valueOf(user.getId()));
            return new ResponseEntity<>(likedComment, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/api/comments/{commentId}")
    public ResponseEntity<?> findCommentById(@PathVariable String commentId) {
        try {
            Comment findComment = commentService.findCommentById(commentId);
            return new ResponseEntity<>(findComment, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

}
