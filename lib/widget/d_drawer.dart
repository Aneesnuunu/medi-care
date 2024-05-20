import 'package:flutter/material.dart';
import '../Theam/theme.dart';

class DoctorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppThemeData.backgroundBlack,

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppThemeData.primaryColor,
              ),
              child: Text(
                'Doctor Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text(
          //     'Home',
          //     style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Add navigation or actions here if needed
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigate to profile page or perform other actions
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'About',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings page or perform other actions
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              // Handle logout action
            },
          ),
        ],
      ),
    );
  }
}
