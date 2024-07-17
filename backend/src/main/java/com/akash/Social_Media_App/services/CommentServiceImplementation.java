package com.akash.Social_Media_App.services;

import com.akash.Social_Media_App.models.Comment;
import com.akash.Social_Media_App.models.Post;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.repository.CommentRepository;
import com.akash.Social_Media_App.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;
@Service
public class CommentServiceImplementation implements CommentService{

    @Autowired
    private PostService postService;
    @Autowired
    private  UserService userService;
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private PostRepository postRepository;

    @Override
    public Comment createComment(Comment comment, String postId, String userId) throws Exception {
        User user=userService.findUserById(userId);
        Post post=postService.findPostById(postId);

        comment.setUser(user);
        comment.setContent(comment.getContent());
        comment.setCreatedAt(LocalDateTime.now());
        Comment savedComment=commentRepository.save(comment);

        post.getComments().add(savedComment);

        postRepository.save(post);

        return savedComment;
    }

    @Override
    public Comment findCommentById(String commentId) throws Exception {
        Optional<Comment> comment=commentRepository.findById(commentId);
        if(comment.isEmpty()){
            throw new Exception("Comment not exist");
        }
        return comment.get();
    }

    @Override
    public Comment likeComment(String commentId, String userId) throws Exception {
        Comment comment=findCommentById(commentId);
        User user=userService.findUserById(userId);
        if(comment.getLiked().contains(user)){
            comment.getLiked().remove(user);
        }
        else{
            comment.getLiked().add(user);
        }
        return commentRepository.save(comment);
    }
}
