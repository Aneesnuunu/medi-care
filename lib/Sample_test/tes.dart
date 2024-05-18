import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:medi_care/Theam/theme.dart';

class MyAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var appointments = snapshot.data?.get('appointments') ?? [];
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                var appointment = appointments[index];
                return ListTile(
                  leading: Icon(Icons.event, color: AppThemeData.primaryColor),
                  title: Text(
                    DateFormat('yyyy-MM-dd').format(DateTime.parse(appointment['date'])),
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    appointment['dayName'],
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    appointment['time'],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
