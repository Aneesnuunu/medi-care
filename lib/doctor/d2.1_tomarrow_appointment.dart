import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../Theam/theme.dart';
import 'd5_patient_profile.dart';

class NextDayAppointments extends StatefulWidget {
  @override
  _NextDayAppointmentsState createState() => _NextDayAppointmentsState();
}

class _NextDayAppointmentsState extends State<NextDayAppointments> {
  @override
  Widget build(BuildContext context) {
    // Get the next day's date
    DateTime nextDate = DateTime.now().add(Duration(days: 1));
    // Format the next day's date to match the date format in Firestore
    String formattedNextDate = DateFormat('yyyy-MM-dd').format(nextDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tomorrow Appointments",
          style: TextStyle(color: AppThemeData.primaryColor),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('User').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<QueryDocumentSnapshot> userDocs = snapshot.data!.docs;
            List<Widget> appointmentWidgets = [];

            for (var userDoc in userDocs) {
              Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

              if (userData.containsKey('appointments')) {
                List<dynamic> appointments =
                List<dynamic>.from(userData['appointments'] ?? []);

                // Filter appointments for the next day
                appointments = appointments.where((appointment) =>
                appointment['date'] == formattedNextDate).toList();

                // Sort appointments by time
                appointments.sort((a, b) =>
                    DateFormat('hh:mm a').parse(a['time']).compareTo(
                        DateFormat('hh:mm a').parse(b['time'])));

                for (var appointment in appointments) {
                  String time = appointment['time'];
                  String userName = userData['name'];
                  String age = userData['age'];
                  String profileImageUrl = userData['profileImageUrl'];
                  String email = userData['email'];
                  String phone = userData['phone'];
                  String place = userData['place'];
                  String gender = userData['gender'];
                  String blood = userData['blood'];
                  String size = userData['size'];

                  appointmentWidgets.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppThemeData.primaryColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profileImageUrl),
                        ),
                        subtitle: Text(
                          'Age: $age',
                          style: TextStyle(color: Colors.white),
                        ),
                        title: Text(
                          userName,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          time,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientProfilePage(
                                userName: userName,
                                age: age,
                                profileImageUrl: profileImageUrl,
                                email: email,
                                phone: phone,
                                place: place,
                                gender: gender,
                                blood: blood,
                                size: size,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ));
                }
              }
            }

            return ListView(
              children: appointmentWidgets,
            );
          }
        },
      ),
    );
  }
}
