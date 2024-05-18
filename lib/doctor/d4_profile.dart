import 'package:flutter/material.dart';

import '../Theam/theme.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppThemeData.primaryColor),
          ),
        ),
        body:  const Column(
          children: [
            SizedBox(height: 40,),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
              ),
            )

          ],
        ),
      );
  }
}
