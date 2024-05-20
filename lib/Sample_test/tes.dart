import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Theam/theme.dart';

class MyAppointments extends StatefulWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  const MyAppointments({super.key, this.selectedDate, this.selectedTime});

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appointments",
          style: TextStyle(
              color: AppThemeData.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var appointments = snapshot.data?.get('appointments') ?? [];
            // Sort appointments by date and time
            appointments.sort((a, b) {
              DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm a');
              DateTime dateTimeA =
                  dateFormat.parse('${a['date']} ${a['time']}');
              DateTime dateTimeB =
                  dateFormat.parse('${b['date']} ${b['time']}');
              return dateTimeA.compareTo(dateTimeB);
            });
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                var appointment = appointments[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: AppThemeData.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          leading: const Icon(Icons.event, color: Colors.white),
                          title: Text(
                            DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(appointment['date'])),
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            appointment['dayName'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: Text(
                            appointment['time'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Text('Confirm Appointment Cancellation'),
                                  content: Text(
                                      'Are you sure you want to cancel this appointment?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Delete the appointment from the database
                                        FirebaseFirestore.instance
                                            .collection('User')
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .update({
                                          'appointments':
                                              FieldValue.arrayRemove(
                                                  [appointment]),
                                        }).then((value) {
                                          print(
                                              'Appointment deleted successfully');
                                          setState(() {
                                            appointments.removeAt(index);
                                          });
                                        }).catchError((error) {
                                          print(
                                              'Failed to delete appointment: $error');
                                        });
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent),
                          child: const Text(
                            'Cancel Appointment',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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
