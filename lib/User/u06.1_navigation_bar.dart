import 'package:flutter/material.dart';

import '../Theam/theme.dart';
import 'u06_home_page.dart';
import 'u07_calender.dart';
import 'u08_profile.dart';

class NavigationBar123 extends StatefulWidget {
  const NavigationBar123({super.key});


  @override
  _NavigationBar123 createState() => _NavigationBar123();
}

class _NavigationBar123 extends State<NavigationBar123> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
     const HomePage(),
    const CalendarPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: AppThemeData.primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
