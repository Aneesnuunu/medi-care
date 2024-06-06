import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/User/u06_home_page.dart';
import 'package:medi_care/User/u07_calender.dart';
import 'package:medi_care/User/u08_profile.dart';

enum _SelectedTab { home, add, person }

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    CalendarPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages.elementAt(_selectedTab.index),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        height: 60,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black.withOpacity(0.1),
        onTap: _handleIndexChanged,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
            selectedColor: AppThemeData.primaryColor,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.calendar,
            unselectedIcon: IconlyLight.calendar,
            selectedColor: AppThemeData.primaryColor,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.user_2,
            unselectedIcon: IconlyLight.user,
            selectedColor: AppThemeData.primaryColor,
          ),
        ],
      ),
    );
  }
}
