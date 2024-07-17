package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.models.Chat;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.request.CreateChatRequest;
import com.akash.Social_Media_App.services.ChatService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ChatController {

    @Autowired
    private ChatService chatService;
    @Autowired
    private UserService userService;

    @PostMapping("/api/chats")
    public ResponseEntity<?> createChat(@RequestHeader("Authorization") String jwt, @RequestBody CreateChatRequest req) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            User user2 = userService.findUserById(String.valueOf(req.getUserId()));
            Chat chat = chatService.createChat(reqUser, user2);
            return new ResponseEntity<>(chat, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/api/chats")
    public ResponseEntity<?> findUsersChat(@RequestHeader("Authorization") String jwt) {
        try {
            User reqUser = userService.findUserByJwt(jwt);
            List<Chat> chats = chatService.findUsersChat(reqUser.getId());
            return new ResponseEntity<>(chats, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

}
