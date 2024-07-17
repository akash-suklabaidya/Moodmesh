package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.models.Message;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.services.MessageService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class MessageController {

    @Autowired
    private MessageService messageService;
    @Autowired
    private UserService userService;

    @PostMapping("/api/messages/chat/{chatId}")
    public Message createMessage(@RequestBody Message req, @RequestHeader("Authorization")String jwt,@PathVariable String chatId) throws Exception {

        User reqUser=userService.findUserByJwt(jwt);

        Message message=messageService.createMessage(reqUser,chatId,req);

        return message;

    }

    @GetMapping("/api/messages/chat/{chatId}")
    public List<Message> findChatMessage(@PathVariable String chatId) throws Exception {

//        User reqUser=userService.findUserByJwt(jwt);

        List<Message> messages=messageService.findChatsMessages(chatId);

        return messages;

    }

}
