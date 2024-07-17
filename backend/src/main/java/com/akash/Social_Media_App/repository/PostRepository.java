package com.akash.Social_Media_App.repository;

import com.akash.Social_Media_App.models.Post;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;

public interface PostRepository extends MongoRepository<Post,String> {


    @Query("{ 'user.id': ?0 }")
    List<Post> findPostByUserId(String userId);

}
