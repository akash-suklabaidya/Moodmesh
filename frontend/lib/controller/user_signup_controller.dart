import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginResult {
  final int statusCode;
  final String message;

  LoginResult(this.statusCode, this.message);

  @override
  String toString() {
    return 'LoginResult(statusCode: $statusCode, message: $message)';
  }
}

class SignupController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    genderController.dispose();
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your gender';
    }
    return null;
  }

  Future<LoginResult> signup() async {
    final url = Uri.parse('http://192.168.1.3:8080/auth/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'gender': genderController.text,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        // return responseData['message'] ?? 'Signup successful';
        return LoginResult(response.statusCode, 'Signup successful');
      } else if (response.statusCode == 400) {
        return LoginResult(
            response.statusCode, 'Email already registered. Please try again');
      } else {
        // Handle error response
        final errorData = jsonDecode(response.body);
        return errorData['message'] ?? 'Signup failed';
      }
    } catch (e) {
      print('Error: $e');
      return LoginResult(174, 'An error occurred. Please try again.');
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }
}
