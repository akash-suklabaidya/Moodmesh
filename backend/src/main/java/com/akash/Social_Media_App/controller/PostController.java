package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.models.Post;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.response.ApiResponse;
import com.akash.Social_Media_App.services.PostService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class PostController {
    @Autowired
    PostService postService;
    @Autowired
    UserService userService;

    @PostMapping("/api/posts")
    public ResponseEntity<?> createPost(@RequestBody Post post, @RequestHeader("Authorization") String jwt) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            Post createdPost = postService.createNewPost(post, String.valueOf(reqUser.getId()));
            return new ResponseEntity<>(createdPost, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/api/posts/{postId}")
    public ResponseEntity<?> deletePost(@PathVariable String postId, @RequestHeader("Authorization") String jwt) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            String message = postService.deletePost(postId, String.valueOf(reqUser.getId()));
            ApiResponse res = new ApiResponse(message, true);
            return new ResponseEntity<>(res, HttpStatus.OK);
        } catch (Exception e) {
            ApiResponse res = new ApiResponse(e.getMessage(), false);
            return new ResponseEntity<>(res, HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/api/posts/{postId}")
    public ResponseEntity<?> findPostByIdHandler(@PathVariable String postId) {
        try {
            Post post = postService.findPostById(postId);
            return new ResponseEntity<>(post, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/api/posts/user/{userId}")
    public ResponseEntity<?> findUsersPost(@PathVariable String userId) {
        try {
            List<Post> posts = postService.findPostByUserId(userId);
            return new ResponseEntity<>(posts, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/api/posts")
    public ResponseEntity<?> findAllPost() {
        try {
            List<Post> posts = postService.findAllPost();
            return new ResponseEntity<>(posts, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/api/posts/save/{postId}")
    public ResponseEntity<?> savePostHandler(@PathVariable String postId, @RequestHeader("Authorization") String jwt) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            Post post = postService.savedPost(postId, String.valueOf(reqUser.getId()));
            return new ResponseEntity<>(post, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping("/api/posts/like/{postId}")
    public ResponseEntity<?> likePostHandler(@PathVariable String postId, @RequestHeader("Authorization") String jwt) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            Post post = postService.likePost(postId, String.valueOf(reqUser.getId()));
            return new ResponseEntity<>(post, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/api/posts/saved")
    public ResponseEntity<?> findUsersSavedPost(@RequestHeader("Authorization") String jwt) {
        try {
            String userId= userService.findUserByJwt(jwt).getId();
            List<Post> posts = postService.findUsersSavedPost(userId);
            return new ResponseEntity<>(posts, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

}
