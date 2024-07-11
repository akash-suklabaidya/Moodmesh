import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: klight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80), // Adjusted padding with SizedBox
              Text(
                'MoodMesh',
                style: kAppTitle.copyWith(
                  fontSize: kAppTitle.fontSize! * textScaleFactor,
                ),
                textAlign: TextAlign.center,
              ),
              Lottie.asset(
                'assets/animation1.json', // Replace with your Lottie file path
                width: 200 * textScaleFactor, // Adjust the size as needed
                height: 200 * textScaleFactor,
                fit: BoxFit.cover,
              ),
              const Spacer(flex: 7),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Your Premier ",
                              style: TextStyle(
                                fontSize: 30 * textScaleFactor,
                                fontWeight: FontWeight.bold,
                                color: kblack,
                              ),
                            ),
                            TextSpan(
                              text: "Social Connection App",
                              style: TextStyle(
                                fontSize: 30 * textScaleFactor,
                                fontWeight: FontWeight.bold,
                                color: kPrimary,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30 * textScaleFactor),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kblacklight,
                          fontWeight: FontWeight.w600,
                          fontSize: 15 * textScaleFactor,
                        ),
                      ),
                      SizedBox(height: 30 * textScaleFactor),
                      SizedBox(
                        width: double.infinity,
                        height: 50 * textScaleFactor,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to sign-up/sign-in page
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
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15 * textScaleFactor,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: kPrimary,
                                decoration: TextDecoration.underline,
                                fontSize: 15 * textScaleFactor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
