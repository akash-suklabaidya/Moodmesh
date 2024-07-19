import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/user_login_controller.dart';
import 'package:frontend/pages/default_page.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/loading.dart';
import 'package:frontend/utils/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController _loginController = LoginController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        LoginResult loginResult = await _loginController.login();
        if (loginResult.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DefaultPage()),
          );
        }
        ToastUtil.showToast(loginResult.message);
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
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Sign In',
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
                      "Hi! Welcome back, you've been missed",
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
                          controller: _loginController.emailController,
                          hint: 'Email',
                          validator: _loginController.validateEmail,
                        ),
                        _buildTextField(
                            controller: _loginController.passwordController,
                            hint: 'Password',
                            validator: _loginController.validatePassword,
                            obscureText: !_isPasswordVisible,
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
                          onPressed: _login,
                          text: "Login",
                        ),
                        SizedBox(height: 30 * textScaleFactor),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Dont't have an account? ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14 * textScaleFactor,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
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
                                          builder: (context) => const SignUp(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    bool obscureText = false,
    suffixIcon,
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
