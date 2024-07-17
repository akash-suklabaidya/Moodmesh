package com.akash.Social_Media_App.repository;

import com.akash.Social_Media_App.models.Message;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface MessageRepository extends MongoRepository<Message,String> {

    public List<Message> findByChatId(String chatId);

}
