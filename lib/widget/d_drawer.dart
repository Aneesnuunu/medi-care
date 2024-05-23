import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Theam/theme.dart';
import '../User/u04_login_screen.dart';
import '../User/u14_about.dart';
import '../doctor/d4_profile.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const DoctorProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'About',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const AboutMePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: ()  async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppThemeData.backgroundBlack,
                    title: const Text('Logout Confirmation',style: TextStyle(color: Colors.white),),
                    content: const Text('Are you sure you want to logout?',style: TextStyle(color: Colors.white),),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: const Text('Logout',style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout == true) {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                );
              }
            },

          ),
          SizedBox(height: 50,)
,
          ListTile(
            leading: Icon(Icons.event_busy_outlined),
            title: Text(
              'Take a Leave',
              style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const AboutMePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
