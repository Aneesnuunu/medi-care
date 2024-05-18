import 'package:flutter/material.dart';

import '../Theam/theme.dart';
import '../User/u07_calender.dart';
import 'd1_home.dart';
import 'd4_profile.dart';

class DoctorNavigationBar extends StatefulWidget {
  const DoctorNavigationBar({super.key});



  @override
  _DoctorNavigationBar createState() => _DoctorNavigationBar();
}

class _DoctorNavigationBar extends State<DoctorNavigationBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    const DoctorHomePage(),
    const CalendarPage(),
    const DoctorProfilePage(),
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
