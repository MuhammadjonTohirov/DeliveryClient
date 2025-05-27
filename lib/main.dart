import 'package:delivery_client/screens/auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_client/theme/app_theme.dart';
// import 'package:delivery_client/screens/main_screen.dart'; // Import MainScreen
// import 'package:provider/provider.dart'; // Uncomment if using Provider
// import 'package:firebase_core/firebase_core.dart'; // Uncomment if using Firebase

// Import your providers here if you plan to use them globally
// import 'package:delivery_client/providers/auth_provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // Uncomment if you need to initialize bindings before runApp

  // Uncomment the following if you are using Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform, // Ensure you have firebase_options.dart
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // If using global providers, wrap MaterialApp with MultiProvider
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => AuthProvider()),
    //     // Add other global providers here
    //   ],
    //   child: MaterialApp(
    //     title: 'Delivery Client',
    //     theme: AppTheme.lightTheme,
    //     darkTheme: AppTheme.darkTheme, // Optional: if you have a dark theme
    //     themeMode: ThemeMode.system, // Or ThemeMode.light, ThemeMode.dark
    //     debugShowCheckedModeBanner: false,
    //     home: const WelcomeScreen(), // Start with WelcomeScreen
    //     // Define routes here if you are using named routes
    //     // routes: {
    //     //   '/': (context) => WelcomeScreen(),
    //     //   '/login': (context) => LoginScreen(),
    //     //   '/signup': (context) => SignUpScreen(),
    //     //   '/home': (context) => HomeScreen(),
    //     // },
    //   ),
    // );

    // Basic setup without global providers for now
    return MaterialApp(
      title: 'Delivery Client',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme, // Optional: if you have a dark theme
      themeMode: ThemeMode.system, // Or ThemeMode.light, ThemeMode.dark
      debugShowCheckedModeBanner: false,
      // home: const MainScreen(), // Temporarily start with MainScreen for development
      home: const WelcomeScreen(), // Start with WelcomeScreen - Revert to this for auth flow
    );
  }
}
