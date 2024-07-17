package com.akash.Social_Media_App.repository;

import com.akash.Social_Media_App.models.Story;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface StoryRepository extends MongoRepository<Story,String> {

    public List<Story> findByUserId(String userId);

}
