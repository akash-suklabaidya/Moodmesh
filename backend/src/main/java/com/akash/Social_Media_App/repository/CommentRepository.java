package com.akash.Social_Media_App.repository;

import com.akash.Social_Media_App.models.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Comment,Integer> {



}
