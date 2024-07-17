package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.Chat;
import com.akash.Social_Media_App.models.Message;
import com.akash.Social_Media_App.models.User;

import java.util.List;

public interface MessageService {

    public Message createMessage(User user, String chatId, Message req) throws Exception;

    public List<Message> findChatsMessages(String chatId) throws Exception;



}
