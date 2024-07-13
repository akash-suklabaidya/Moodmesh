import 'package:flutter/material.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/toast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

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
        String message = await _userController.signup();
        ToastUtil.showToast(message);
      } catch (e) {
        ToastUtil.showToast("Registration failed: $e");
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
                const SizedBox(height: 100),
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 25 * textScaleFactor,
                    fontWeight: FontWeight.w600,
                    color: kblack,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Fill your information below or register with your social account",
                    style: TextStyle(
                      color: kblacklight,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTextField(
                        controller: _userController.firstNameController,
                        hint: 'First Name',
                        validator: _userController.validateFirstName,
                      ),
                      _buildTextField(
                        controller: _userController.lastNameController,
                        hint: 'Last Name',
                        validator: _userController.validateLastName,
                      ),
                      _buildTextField(
                        controller: _userController.emailController,
                        hint: 'Email',
                        validator: _userController.validateEmail,
                      ),
                      _buildTextField(
                        controller: _userController.genderController,
                        hint: 'Gender',
                        validator: _userController.validateGender,
                      ),
                      _buildTextField(
                        controller: _userController.passwordController,
                        hint: 'Password',
                        obscureText: true,
                        validator: _userController.validatePassword,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50 * textScaleFactor,
                        child: ElevatedButton(
                          onPressed: _signup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimary,
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15 * textScaleFactor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: kbluish.withOpacity(0.1),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
