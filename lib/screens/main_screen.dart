import 'package:flutter/material.dart';
import 'package:delivery_client/screens/home/home_screen.dart';
import 'package:delivery_client/screens/search/search_screen.dart';
import 'package:delivery_client/screens/orders/orders_screen.dart';
import 'package:delivery_client/screens/profile/profile_screen.dart';
import 'package:delivery_client/utils/constants.dart'; // For kPrimaryColor if needed directly

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[HomeScreen(), SearchScreen(), OrdersScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar is handled by individual screens like HomeScreen
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), activeIcon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: kPrimaryColor, // This is handled by theme
        // unselectedItemColor: Colors.grey, // This is handled by theme
        onTap: _onItemTapped,
        // type: BottomNavigationBarType.fixed, // This is handled by theme
        // showUnselectedLabels: true, // This is handled by theme
      ),
    );
  }
}
