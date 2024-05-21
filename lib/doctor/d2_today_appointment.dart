// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../Theam/theme.dart';
// import 'd5_patient_profile.dart';
//
// class Appointment {
//   final String userName;
//   final String age;
//   final String profileImageUrl;
//   final String time;
//   final String email;
//   final String phone;
//   final String place;
//   final String gender;
//   final String blood;
//   final String size;
//
//   Appointment({
//     required this.userName,
//     required this.age,
//     required this.profileImageUrl,
//     required this.time,
//     required this.email,
//     required this.phone,
//     required this.place,
//     required this.gender,
//     required this.blood,
//     required this.size,
//   });
// }
//
// class AppointmentProvider extends ChangeNotifier {
//   List<Appointment> _appointments = [];
//
//   List<Appointment> get appointments => _appointments;
//
//   void setAppointments(List<Appointment> appointments) {
//     _appointments = appointments;
//     notifyListeners();
//   }
// }
//
// class MyAppointments extends StatelessWidget {
//   const MyAppointments({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AppointmentProvider(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Appointments",
//             style: TextStyle(color: AppThemeData.primaryColor),
//           ),
//         ),
//         body: const AppointmentList(),
//       ),
//     );
//   }
// }
//
// class AppointmentList extends StatelessWidget {
//   const AppointmentList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var appointmentProvider = Provider.of<AppointmentProvider>(context);
//
//     DateTime currentDate = DateTime.now();
//     String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('User').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           List<Appointment> appointments = [];
//
//           for (var userDoc in snapshot.data!.docs) {
//             Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
//
//             if (userData.containsKey('appointments')) {
//               List<dynamic> rawAppointments = List<dynamic>.from(userData['appointments'] ?? []);
//
//               rawAppointments = rawAppointments
//                   .where((appointment) => appointment['date'] == formattedCurrentDate)
//                   .toList();
//
//               rawAppointments.sort((a, b) => DateFormat('hh:mm a').parse(a['time']).compareTo(DateFormat('hh:mm a').parse(b['time'])));
//
//               for (var rawAppointment in rawAppointments) {
//                 appointments.add(Appointment(
//                   userName: userData['name'],
//                   age: userData['age'],
//                   profileImageUrl: userData['profileImageUrl'],
//                   time: rawAppointment['time'],
//                   email: userData['email'],
//                   phone: userData['phone'],
//                   place: userData['place'],
//                   gender: userData['gender'],
//                   blood: userData['blood'],
//                   size: userData['size'],
//                 ));
//               }
//             }
//           }
//
//           appointmentProvider.setAppointments(appointments);
//
//           return ListView.builder(
//             itemCount: appointments.length,
//             itemBuilder: (context, index) {
//               var appointment = appointments[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppThemeData.primaryColor,
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 25,
//                       backgroundImage: NetworkImage(appointment.profileImageUrl),
//                     ),
//                     subtitle: Text(
//                       'Age: ${appointment.age}',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     title: Text(
//                       appointment.userName,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     trailing: Text(
//                       appointment.time,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PatientProfilePage(
//                             userName: appointment.userName,
//                             age: appointment.age,
//                             profileImageUrl: appointment.profileImageUrl,
//                             email: appointment.email,
//                             phone: appointment.phone,
//                             place: appointment.place,
//                             gender: appointment.gender,
//                             blood: appointment.blood,
//                             size: appointment.size,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Theam/theme.dart';
import 'd5_patient_profile.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  final BuildContext context; // Add the context parameter

  const DoctorAppointmentsPage({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedCurrentDate = currentDate.toIso8601String().split('T')[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Appointments",
          style: TextStyle(
            color: AppThemeData.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('User').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final userName = user['name'];
                final age = user['age'];
                final userId = user.id; // Get the user ID

                // Perform a null check on user.data()
                final userData = user.data() as Map<String, dynamic>?;

                // Check if userData is not null and contains the key 'profileImageUrl'
                final profileImageUrl =
                userData != null && userData.containsKey('profileImageUrl')
                    ? userData['profileImageUrl']
                    : '';

                // Retrieve additional data such as email, phone, place, gender, blood, size
                final email = userData?['email'] ?? '';
                final phone = userData?['phone'] ?? '';
                final place = userData?['place'] ?? '';
                final gender = userData?['gender'] ?? '';
                final blood = userData?['blood'] ?? '';
                final size = userData?['size'] ?? '';

                final appointments = user.reference
                    .collection('appointments')
                    .where('date', isEqualTo: formattedCurrentDate)
                    .snapshots();

                return StreamBuilder<QuerySnapshot>(
                  stream: appointments,
                  builder: (context, appointmentSnapshot) {
                    if (appointmentSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (appointmentSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${appointmentSnapshot.error}'));
                    } else {
                      final appointmentDocs =
                      appointmentSnapshot.data!.docs.toList();
                      // Sort appointmentDocs by time
                      appointmentDocs.sort((a, b) => (a['time'] as String)
                          .compareTo(b['time'] as String));

                      return Column(
                        children: appointmentDocs.map((appointment) {
                          final appointmentData =
                          appointment.data() as Map<String, dynamic>;
                          final appointmentId = appointment.id;
                          final date = appointmentData['date'] as String?;
                          final dayName =
                          appointmentData['dayName'] as String?;
                          final time = appointmentData['time'] as String?;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
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
                                      date: date ?? '', // Provide a default value if date is null
                                      appointmentId: appointmentId,
                                      userId: userId,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                  color: AppThemeData.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: profileImageUrl.isNotEmpty
                                            ? CircleAvatar(
                                          backgroundImage:
                                          NetworkImage(profileImageUrl),
                                        )
                                            : const CircleAvatar(),
                                        title: Text(
                                          userName,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          '$age',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        trailing: Text(
                                          time ?? '',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        appointmentId,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
