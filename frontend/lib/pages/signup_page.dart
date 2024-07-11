import 'package:flutter/material.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:frontend/utils/constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = UserController();

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _userController.signup();

        // Show a snackbar with the collected data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Signed up as ${_userController.nameController.text}')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: klight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30 * textScaleFactor,
                      fontWeight: FontWeight.w600,
                      color: kblack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Fill your information below or register with your social account",
                    style: TextStyle(
                        color: kblacklight, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _userController.nameController,
                          decoration: InputDecoration(labelText: 'Name'),
                          validator: _userController.validateName,
                        ),
                        TextFormField(
                          controller: _userController.emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: _userController.validateEmail,
                        ),
                        TextFormField(
                          controller: _userController.passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: _userController.validatePassword,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: _signup,
                            child: Text('Sign Up'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
