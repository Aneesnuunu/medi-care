import 'package:flutter/material.dart';

import '../Theam/theme.dart';
import '../widget/carousel.dart';
import 'd2.1_tomarrow_appointment.dart';
import 'd2.2_day_after_tomarrow_appointment.dart';
import 'd2_today_appointment.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Hi Doctor",
            style: TextStyle(
                color: AppThemeData.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(
        //         Icons.menu,
        //         color: AppThemeData.primaryColor,
        //       ),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //     );
        //   },
        // ),
      ),
      body: ListView(
        children: [
          Carousel(),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              'My Today Appointment',
              style: TextStyle(color: Colors.white),
            ),
            tileColor: AppThemeData.primaryColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyAppointments()),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            leading: Icon(Icons.calendar_today, color: Colors.white),
            trailing: Icon(Icons.arrow_forward, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              'My Tomarrow Appointment',
              style: TextStyle(color: Colors.white),
            ),
            tileColor: AppThemeData.primaryColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NextDayAppointments()),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            leading: Icon(Icons.calendar_today, color: Colors.white),
            trailing: Icon(Icons.arrow_forward, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              'Day After Tomarrow Appointment',
              style: TextStyle(color: Colors.white),
            ),
            tileColor: AppThemeData.primaryColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DayAfterTomorrowAppointments()),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            leading: Icon(Icons.calendar_today, color: Colors.white),
            trailing: Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
