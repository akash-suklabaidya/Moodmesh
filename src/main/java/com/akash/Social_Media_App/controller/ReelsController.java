package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.models.Reels;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.services.ReelsService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
public class ReelsController {

    @Autowired
    private ReelsService reelsService;
    @Autowired
    private UserService userService;

    @PostMapping("/api/reels")
    public Reels createReels(@RequestBody Reels reel, @RequestHeader("Authorization")String jwt){
        User reqUSer=userService.findUserByJwt(jwt);
        Reels createdReels=reelsService.createReels(reel,reqUSer);
        return createdReels;
    }

    @GetMapping("/api/reels")
    public List<Reels> findAllReels(){
        return reelsService.findAllReels();
    }

    @GetMapping("/api/reels/user/{userId}")
    public List<Reels> findUserReels(@PathVariable Integer userId) throws Exception {

        return reelsService.findUsersReels(userId);

    }


}
