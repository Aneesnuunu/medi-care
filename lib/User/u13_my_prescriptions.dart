import 'package:flutter/material.dart';

import '../Theam/theme.dart';

class MyPrescriptions extends StatefulWidget {
  const MyPrescriptions({super.key});

  @override
  State<MyPrescriptions> createState() => _MyPrescriptionsState();
}

class _MyPrescriptionsState extends State<MyPrescriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Prescriptions",
          style: TextStyle(
              color: AppThemeData.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),


    );
  }
}

