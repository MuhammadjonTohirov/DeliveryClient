import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null, // Will be managed by MainScreen's AppBar or have its own
      body: Center(child: Text('Profile Screen - Placeholder')),
    );
  }
}
