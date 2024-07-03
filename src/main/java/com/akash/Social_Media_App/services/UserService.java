package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.User;

import java.util.List;

public interface UserService {

    public User registerUser(User user);

    public User findUserById(Integer userId) throws Exception;

    public User findUserByEmail(String email);

    public User followUser(Integer userId1, Integer userId2) throws Exception;

    public User updateUser(User user,Integer userId) throws Exception;

    public List<User> searchUser(String query);

    public User findUserByJwt(String jwt);

}
