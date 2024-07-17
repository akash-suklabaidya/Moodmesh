package com.akash.Social_Media_App.repository;

import com.akash.Social_Media_App.models.Chat;
import com.akash.Social_Media_App.models.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ChatRepository extends MongoRepository<Chat,String> {

    public List<Chat> findByUsersId(String userId);

    @Query("{ 'users': { $all: [?0, ?1] } }")
    public Chat findChatByUsersId(String user, String reqUser);


}
