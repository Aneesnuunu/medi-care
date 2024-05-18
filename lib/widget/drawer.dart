import 'package:flutter/material.dart';
import '../Theam/theme.dart';
import '../User/u08_profile.dart';
import '../User/u12_my_appointments.dart';
import '../User/u13_my_prescriptions.dart';
import '../User/u14_about.dart';
import '../User/u15_whatsapp_support.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(backgroundColor:AppThemeData.backgroundBlack,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[const
          SizedBox(
            height: 150,
      child:  DrawerHeader(
              decoration: BoxDecoration(
                color: AppThemeData.primaryColor,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Appointments',style: TextStyle(color: AppThemeData.primaryColor,fontSize: 22),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyAppointments(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Previous Prescriptions',style: TextStyle(color:AppThemeData.primaryColor,fontSize: 22),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyPrescriptions(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('My Profile',style: TextStyle(color: AppThemeData.primaryColor,fontSize: 22),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Support',style: TextStyle(color:AppThemeData.primaryColor,fontSize: 22),),
            onTap: () {
            },
          ),
          ListTile(
            title: const Text('WhatsApp Support',style: TextStyle(color: AppThemeData.primaryColor,fontSize: 22),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WhatsappSupport(
                  ),
                ),
              );

            },
          ),
          ListTile(
            title: const Text('About',style: TextStyle(color: AppThemeData.primaryColor,fontSize: 22),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutMePage(),
                ),
              );
            },
          ),
          // Add more list tiles for additional items in the drawer
        ],
      ),
    );
  }
}
