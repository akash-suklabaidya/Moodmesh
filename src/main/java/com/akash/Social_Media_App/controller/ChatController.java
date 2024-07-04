package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.models.Chat;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.request.CreateChatRequest;
import com.akash.Social_Media_App.services.ChatService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ChatController {

    @Autowired
    private ChatService chatService;
    @Autowired
    private UserService userService;

    @PostMapping("/api/chats")
    public Chat createChat(@RequestHeader("Authorization")String jwt,@RequestBody CreateChatRequest req) throws Exception {
        User reqUser=userService.findUserByJwt(jwt);
        User user2=userService.findUserById(req.getUserId());
        Chat chat=chatService.createChat(reqUser,user2);
        return chat;
    }


    @GetMapping("/api/chats")
    public List<Chat> findUsersChat(@RequestHeader("Authorization")String jwt){
        User reqUser=userService.findUserByJwt(jwt);
        return chatService.findUsersChat(reqUser.getId());
    }

}
