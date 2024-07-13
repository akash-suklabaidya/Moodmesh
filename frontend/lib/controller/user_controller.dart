import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController {
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

  Future<String> signup() async {
    final url = Uri.parse('http://192.168.1.4:8080/auth/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'gender': genderController.text,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return 'Signup successful';
    } else if (response.statusCode == 400) {
      return 'Email already registered. Please try again';
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Signup failed';
    }
  }
}
