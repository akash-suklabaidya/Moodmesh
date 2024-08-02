package com.akash.Social_Media_App.repository;


import com.akash.Social_Media_App.models.Post;
import com.akash.Social_Media_App.models.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

//class and uske unique identifier ka type
public interface UserRepository extends MongoRepository<User,String> {
    
    public User findByEmail(String email);

    @Query("{ '$or' : [ { 'firstName' : { $regex: ?0, $options: 'i' } }, { 'lastName' : { $regex: ?0, $options: 'i' } }, { 'email' : { $regex: ?0, $options: 'i' } } ] }")
    List<User> searchUser(String query);

    long countBySavedPostsContains(String postId);

}
