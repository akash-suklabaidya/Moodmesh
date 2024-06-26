package com.akash.Social_Media_App.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.akash.Social_Media_App.models.User;

//class and uske unique identifier ka type
public interface UserRepository extends JpaRepository <User,Integer>{
    


}
