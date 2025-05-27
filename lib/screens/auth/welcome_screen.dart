import 'package:delivery_client/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_client/utils/constants.dart';
import 'package:delivery_client/screens/auth/login_screen.dart';
import 'package:delivery_client/screens/auth/registration_screen.dart';
// import 'package:delivery_client/screens/home/home_screen.dart'; // For guest mode

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Placeholder for App Logo
            const Icon(Icons.delivery_dining, size: 100, color: kPrimaryColor),
            const SizedBox(height: kDefaultPadding * 2),
            Text(
              kAppTagline,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: kNeutralDarkGrayColor),
            ),
            const SizedBox(height: kDefaultPadding * 3),
            // horizontal padding 20 on both sides
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: kDefaultPadding),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kNeutralWhiteColor,
                foregroundColor: kPrimaryColor,
                side: const BorderSide(color: kPrimaryColor),
              ),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: kDefaultPadding * 2),
            TextButton(
              onPressed: () {
                // Navigate to Home Screen (Guest Mode)
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
              },
              child: Text('Skip to browse', style: TextStyle(color: kNeutralDarkGrayColor.withOpacity(0.8))),
            ),
          ],
        ),
      ),
    );
  }
}
