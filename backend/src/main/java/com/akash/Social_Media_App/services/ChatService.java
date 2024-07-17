package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.Chat;
import com.akash.Social_Media_App.models.User;

import java.util.List;

public interface ChatService {

    public Chat createChat(User reqUser,User user2);
    public Chat findChatById(String chatId) throws Exception;
    public List<Chat> findUsersChat(String userId);

}
