package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.Post;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.repository.PostRepository;
import com.akash.Social_Media_App.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class PostServiceImplementation implements PostService{

    @Autowired
    PostRepository postRepository;
    @Autowired
    UserService userService;

    @Autowired
    UserRepository userRepository;
    @Override
    public Post createNewPost(Post post, String userId) throws Exception {

        User user=userService.findUserById(userId);

        Post newPost=new Post();
        newPost.setCaption(post.getCaption());
        newPost.setImage(post.getImage());
        newPost.setCreatedAt(LocalDateTime.now());
        newPost.setVideo(post.getVideo());
        newPost.setUser(user);
        postRepository.save(newPost);
        return newPost;
    }

    @Override
    public String deletePost(String postId, String userId) throws Exception {
        Post post = findPostById(postId);
        User user = userService.findUserById(userId);

        // You can only delete your post
        if (!Objects.equals(post.getUser().getId(), user.getId())) {
            throw new Exception("You can't delete another user's post");
        }

        // Remove the post from all users' saved posts
        List<User> users = userRepository.findAll(); // Assuming there's a method to get all users
        for (User u : users) {
            if (u.getSavedPosts().contains(post)) {
                u.getSavedPosts().remove(post);
                userRepository.save(u); // Save the user after removal
            }
        }

        // Now delete the post
        postRepository.delete(post);
        return "Post deleted successfully";
    }
//    public String deletePost(String postId, String userId)throws Exception {
//        Post post=findPostById(postId);
//        User user=userService.findUserById(userId);
//
//        //You can only delete your post
//        if(!Objects.equals(post.getUser().getId(), user.getId())){
//            throw new Exception("you can't delete another users post");
//        }
//        postRepository.delete(post);
//        return "post deleted successfully";
//    }

    @Override
    public List<Post> findPostByUserId(String userId) {

        return postRepository.findPostByUserId(userId);

    }

    @Override
    public Post findPostById(String postId)throws Exception {
        Optional<Post> post=postRepository.findById(postId);
        if(post.isEmpty()){
            throw new Exception("post not found with id "+postId);
        }
        return post.get();
    }

    @Override
    public List<Post> findAllPost() {
        return postRepository.findAll();
    }

    @Override
    public Post savedPost(String postId, String userId)throws Exception {
        Post post=findPostById(postId);
        User user=userService.findUserById(userId);

        if(user.getSavedPosts().contains(post)){
            user.getSavedPosts().remove(post);
        }

        else{
            user.getSavedPosts().add(post);
        }
        userRepository.save(user);
        return post;
    }

    @Override
    public Post likePost(String postId, String userId) throws Exception{
        Post post = findPostById(postId);

        // Find the user by their ID
        User user = userService.findUserById(userId);

        if (post.getLiked() == null) {
            post.setLiked(new ArrayList<>());
        }

        // Check if the user is already in the liked list
        boolean isLiked = post.getLiked().stream()
                .anyMatch(likedUser -> likedUser.getId().equals(user.getId()));

        if (isLiked) {
            // Remove the user from the liked list
            post.getLiked().removeIf(likedUser -> likedUser.getId().equals(user.getId()));
        } else {
            // Add the user to the liked list
            post.getLiked().add(user);
        }

        // Save the updated post to the repository
        return postRepository.save(post);
    }

    @Override
    public List<Post> findUsersSavedPost(String userId) throws Exception {
        User user=userService.findUserById(userId);
        if(user!=null){
            return user.getSavedPosts();
        }
        return null;

    }

    @Override
    public long countUsersWhoSavedPost(String postId) {
        return userRepository.countBySavedPostsContains(postId);
    }


}
