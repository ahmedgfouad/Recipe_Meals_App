import 'package:flutter/material.dart';

import 'favorites.dart';
import 'home.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pages = [
    {'page': Home(), 'label': 'Favorites'},
    {'page': Favorite(), 'label': 'Favorites'},
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 17,
          unselectedItemColor: Colors.black,
          selectedIconTheme:  IconThemeData(color: Colors.teal),
          selectedItemColor:  Colors.teal,
          selectedLabelStyle:  TextStyle(
              fontWeight: FontWeight.bold, color: Colors.teal),
          unselectedLabelStyle: TextStyle(color: Colors.black),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
              label: 'Favorites',
              icon: Icon(Icons.favorite),
            ),
          ],
      ),
    );
  }
}
