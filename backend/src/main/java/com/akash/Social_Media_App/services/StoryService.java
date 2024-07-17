package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.Story;
import com.akash.Social_Media_App.models.User;

import java.util.List;

public interface StoryService {

    public Story createStory(Story story, User user);
    public List<Story> findStoryByUserId(String userId) throws Exception;

}
