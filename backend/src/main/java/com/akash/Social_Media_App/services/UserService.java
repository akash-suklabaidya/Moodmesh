package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.exceptions.UserException;
import com.akash.Social_Media_App.models.User;

import java.util.List;

public interface UserService {

    public User registerUser(User user);

    public User findUserById(String String) throws UserException;

    public User findUserByEmail(String email);

    public User followUser(String userId1, String userId2) throws UserException;

    public User updateUser(User user,String userId) throws UserException;

    public List<User> searchUser(String query);

    public User findUserByJwt(String jwt);

}
