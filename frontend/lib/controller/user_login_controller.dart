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

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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

  Future<LoginResult> login() async {
    final url = Uri.parse('http://192.168.1.3:8080/auth/signin');
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'email': emailController.text,
      'password': passwordController.text,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];

        // Save token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        return LoginResult(
            response.statusCode, responseData['message'] ?? 'Login successful');
      } else {
        final errorData = jsonDecode(response.body);
        return LoginResult(400, errorData['message'] ?? 'Login failed');
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
