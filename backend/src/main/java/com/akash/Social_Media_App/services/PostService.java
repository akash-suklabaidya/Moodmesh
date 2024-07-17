package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.Post;

import java.util.List;

public interface PostService {

        Post createNewPost(Post post,String userId) throws Exception;

        String deletePost(String postId,String userId) throws Exception;

        List<Post> findPostByUserId(String userId);

        Post findPostById(String postId) throws Exception;

        List<Post> findAllPost();

        Post savedPost(String postId,String userId) throws Exception;

        Post likePost(String postId,String userId) throws Exception;

        List<Post> findUsersSavedPost(String userId) throws Exception;


}
