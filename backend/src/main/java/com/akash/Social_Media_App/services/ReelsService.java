package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.Reels;
import com.akash.Social_Media_App.models.User;

import java.util.List;

public interface ReelsService {
    public Reels createReels(Reels reel, User user);
    public List<Reels> findAllReels();
    public List<Reels> findUsersReels(String userId) throws Exception;



}
