import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatelessWidget {
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
                const SizedBox(height: 60),
                Text(
                  'MoodMesh',
                  style: kAppTitle.copyWith(
                    fontSize: kAppTitle.fontSize! * textScaleFactor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Lottie.asset(
                  'lib/assets/animations/Animation1.json',
                  width: 200 * textScaleFactor,
                  height: 200 * textScaleFactor,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 240),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Your Premier ",
                        style: TextStyle(
                          fontSize: 25 * textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: kblack,
                        ),
                      ),
                      TextSpan(
                        text: "Social Connection App",
                        style: TextStyle(
                          fontSize: 25 * textScaleFactor,
                          fontWeight: FontWeight.w600,
                          color: kPrimary,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40 * textScaleFactor),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kblacklight,
                    fontWeight: FontWeight.w600,
                    fontSize: 14 * textScaleFactor,
                  ),
                ),
                SizedBox(height: 40 * textScaleFactor),
                SizedBox(
                  width: double.infinity,
                  height: 50 * textScaleFactor,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                    ),
                    child: Text(
                      "Let's Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15 * textScaleFactor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30 * textScaleFactor),
                RichText(
                  textAlign: TextAlign.center,
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
                const SizedBox(height: 40), // Adjusted padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
