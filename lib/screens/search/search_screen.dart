import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null, // Will be managed by MainScreen's AppBar or have its own
      body: Center(child: Text('Search Screen - Placeholder')),
    );
  }
}
