package com.akash.Social_Media_App.controller;

import com.akash.Social_Media_App.config.JwtProvider;
import com.akash.Social_Media_App.models.User;
import com.akash.Social_Media_App.repository.UserRepository;
import com.akash.Social_Media_App.request.LoginRequest;
import com.akash.Social_Media_App.response.AuthResponse;
import com.akash.Social_Media_App.services.CustomerUserDetailService;
import com.akash.Social_Media_App.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private CustomerUserDetailService customerUserDetailService;

    @PostMapping("/signup")
    public AuthResponse createUser(@RequestBody User user)throws Exception {

        if(userRepository.findByEmail(user.getEmail())!=null){
            throw new Exception(("email already used with another account"));
        }

        User newUser = new User();
        newUser.setEmail(user.getEmail());
        newUser.setFirstName(user.getFirstName());
        newUser.setLastName(user.getLastName());
        newUser.setPassword(passwordEncoder.encode(user.getPassword()));
        newUser.setGender(user.getGender());

        User savedUser = userRepository.save(newUser);

        Authentication authentication=new UsernamePasswordAuthenticationToken(savedUser.getEmail(),savedUser.getPassword());

        String token= JwtProvider.generateToken(authentication);

        AuthResponse res=new AuthResponse(token,"registration success");

        return res;
    }

    @PostMapping("/signin")
    public AuthResponse signin(@RequestBody LoginRequest loginRequest){
        Authentication authentication=authenticate(loginRequest.getEmail(),loginRequest.getPassword());
        String token= JwtProvider.generateToken(authentication);

        AuthResponse res=new AuthResponse(token,"login success");

        return res;
    }

    private Authentication authenticate(String email, String password) {
        UserDetails userDetails=customerUserDetailService.loadUserByUsername(email);
        if(userDetails==null){
            throw new BadCredentialsException("invalid username");
        }
        if(!passwordEncoder.matches(password,userDetails.getPassword())){
            throw new BadCredentialsException("password not matched");
        }
        return new UsernamePasswordAuthenticationToken(userDetails,null,userDetails.getAuthorities());
    }


}
