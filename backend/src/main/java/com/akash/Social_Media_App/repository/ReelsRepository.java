package com.akash.Social_Media_App.repository;

import com.akash.Social_Media_App.models.Reels;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ReelsRepository extends MongoRepository<Reels,String> {
    public List<Reels> findByUserId(String userId);
}
