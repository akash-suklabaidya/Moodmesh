import 'package:flutter/material.dart';
import 'package:frontend/utils/constants.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kLilac.withOpacity(0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
              child: Text(
                'MoodMesh',
                style: kAppTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Premier Social Connection App',
                      style: textStyleWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to sign-up/sign-in page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kRoseQuartz,
                      ),
                      child: Text('Get Started'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
