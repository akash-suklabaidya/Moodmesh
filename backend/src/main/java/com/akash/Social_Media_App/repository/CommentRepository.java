package com.akash.Social_Media_App.repository;

import com.akash.Social_Media_App.models.Comment;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface CommentRepository extends MongoRepository<Comment,String> {



}
