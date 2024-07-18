package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.config.JwtProvider;
import com.akash.Social_Media_App.exceptions.UserException;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImplementation implements UserService{

    @Autowired
    UserRepository userRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public User registerUser(User user) {
        User newUser = new User();
        newUser.setEmail(user.getEmail());
        newUser.setFirstName(user.getFirstName());
        newUser.setLastName(user.getLastName());
        newUser.setPassword(passwordEncoder.encode(user.getPassword()));
        newUser.setId(user.getId());
        newUser.setGender(user.getGender());

        User savedUser = userRepository.save(newUser);

        return savedUser;
    }

    @Override
    public User findUserById(String userId) throws UserException {
        Optional<User> user = userRepository.findById(userId);

        if (user.isPresent()) {
            return user.get();
        }

        throw new UserException("User with id " + userId + " not found");
    }

    @Override
    public User findUserByEmail(String email) {
        User user=userRepository.findByEmail(email);
        return user;
    }

    @Override
    public User followUser(String reqUserId, String userId2) throws UserException {
        User reqUser= findUserById(reqUserId);
        User user2= findUserById(userId2);
        if(reqUser.getFollowings().contains(userId2)){
            return null;
        }
        // user1 following user2
        user2.getFollowers().add(reqUser.getId());
        reqUser.getFollowings().add(user2.getId());

        userRepository.save(reqUser);
        userRepository.save(user2);

        return reqUser;
    }

    @Override
    public User updateUser(User user,String userId) throws UserException {
        Optional<User> user1=userRepository.findById(userId);
        if(user1.isEmpty()){
            throw new UserException("user not found with id "+ userId);
        }

        User oldUser=user1.get();
        if(user.getFirstName()!=null){
            oldUser.setFirstName(user.getFirstName());
        }
        if(user.getLastName()!=null){
            oldUser.setLastName(user.getLastName());
        }
        if(user.getEmail()!=null){
            oldUser.setEmail(user.getEmail());
        }
        if(user.getGender()!=null){
            oldUser.setGender(user.getGender());
        }

        if(user.getPassword()!=null){
            oldUser.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        User updatedUSer=userRepository.save(oldUser);

        return updatedUSer;
    }

    @Override
    public List<User> searchUser(String query) {
        return userRepository.searchUser(query);
    }

    @Override
    public User findUserByJwt(String jwt) {
        String email= JwtProvider.getEmailFromJwtToken(jwt);
        User user=userRepository.findByEmail(email);
        return user;
    }
}
