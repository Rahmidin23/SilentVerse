// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'catalog_screen.dart';
import 'events_screen.dart';
import 'reader_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CatalogScreen(),
    EventsScreen(),
    ReaderScreen(),
    ProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Catalog'),
    BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
    BottomNavigationBarItem(icon: Icon(Icons.chrome_reader_mode), label: 'Reader'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _items,
        onTap: _onTabTapped,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
