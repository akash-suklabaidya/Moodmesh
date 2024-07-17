package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.Reels;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.repository.ReelsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ReelsServiceImplementation implements ReelsService{

    @Autowired
    private ReelsRepository reelsRepository;

    @Autowired
    private UserService userService;

    @Override
    public Reels createReels(Reels reel, User user) {

        Reels createReels=new Reels();
        createReels.setTitle(reel.getTitle());
        createReels.setUser(user);
        createReels.setVideo(reel.getVideo());

        return reelsRepository.save(createReels);
    }

    @Override
    public List<Reels> findAllReels() {
        return reelsRepository.findAll();
    }

    @Override
    public List<Reels> findUsersReels(String userId) throws Exception {

        return reelsRepository.findByUserId(userId);
    }
}
