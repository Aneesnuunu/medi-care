import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theam/theme.dart';
import 'u06_home_page.dart';
import 'u07_calender.dart';
import 'u08_profile.dart';

// Create a class to hold the state and manage the selected index
class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class NavigationBar123 extends StatelessWidget {
  const NavigationBar123({Key? key}) : super(key: key);

  // Define the list of widgets here
  static final List<Widget> _widgetOptions = [
    const HomePage(),
    const CalendarPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Wrap the widget tree with ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, _) {
          return Scaffold(
            body: _widgetOptions.elementAt(navigationProvider.selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppThemeData.primaryColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: navigationProvider.selectedIndex,
              selectedItemColor: Colors.white,
              onTap: (index) {
                // Call the updateIndex method to update the selected index
                navigationProvider.updateIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
