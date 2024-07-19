import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/controller/user_signup_controller.dart';
import 'package:frontend/pages/default_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/loading.dart';
import 'package:frontend/utils/toast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final SignupController _SignupController = SignupController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _SignupController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        LoginResult signupResult = await _SignupController.signup();
        if (signupResult.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DefaultPage()),
          );
        }
        ToastUtil.showToast(signupResult.message);
      } catch (e) {
        ToastUtil.showToast("Registration failed: $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        controller: _SignupController.firstNameController,
                        hint: 'First Name',
                        validator: _SignupController.validateFirstName,
                      ),
                      _buildTextField(
                        controller: _SignupController.lastNameController,
                        hint: 'Last Name',
                        validator: _SignupController.validateLastName,
                      ),
                      _buildTextField(
                        controller: _SignupController.emailController,
                        hint: 'Email',
                        validator: _SignupController.validateEmail,
                      ),
                      _buildTextField(
                        controller: _SignupController.genderController,
                        hint: 'Gender',
                        validator: _SignupController.validateGender,
                      ),
                      _buildTextField(
                          controller: _SignupController.passwordController,
                          hint: 'Password',
                          obscureText: !_isPasswordVisible,
                          validator: _SignupController.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          )),
                      const SizedBox(height: 30),
                      LoadingButton(
                        isLoading: _isLoading,
                        onPressed: _signup,
                        text: "Sign Up",
                      ),
                      SizedBox(height: 30 * textScaleFactor),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14 * textScaleFactor,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: kPrimary,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14 * textScaleFactor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40), // Adjusted padding
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
    Widget? suffixIcon,
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
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
