// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
//
// import '../Theam/theme.dart';
// import 'd5_patient_profile.dart';
//
// class DayAfterTomorrowAppointments extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Appointments",
//           style: TextStyle(color: AppThemeData.primaryColor),
//         ),
//       ),
//       body: AppointmentList(),
//     );
//   }
// }
//
// class AppointmentList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Get the date for the day after tomorrow
//     DateTime dayAfterTomorrow = DateTime.now().add(Duration(days: 2));
//     // Format the date for the day after tomorrow to match the date format in Firestore
//     String formattedDayAfterTomorrow =
//     DateFormat('yyyy-MM-dd').format(dayAfterTomorrow);
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('User').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           List<QueryDocumentSnapshot> userDocs = snapshot.data!.docs;
//           List<Widget> appointmentWidgets = [];
//
//           for (var userDoc in userDocs) {
//             Map<String, dynamic> userData =
//             userDoc.data() as Map<String, dynamic>;
//
//             if (userData.containsKey('appointments')) {
//               List<dynamic> appointments =
//               List<dynamic>.from(userData['appointments'] ?? []);
//
//               // Filter appointments for the day after tomorrow
//               appointments = appointments
//                   .where((appointment) =>
//               appointment['date'] == formattedDayAfterTomorrow)
//                   .toList();
//
//               // Sort appointments by time
//               appointments.sort((a, b) => DateFormat('hh:mm a')
//                   .parse(a['time'])
//                   .compareTo(DateFormat('hh:mm a').parse(b['time'])));
//
//               for (var appointment in appointments) {
//                 String time = appointment['time'];
//                 String userName = userData['name'];
//                 String age = userData['age'];
//                 String profileImageUrl = userData['profileImageUrl'];
//                 String email = userData['email'];
//                 String phone = userData['phone'];
//                 String place = userData['place'];
//                 String gender = userData['gender'];
//                 String blood = userData['blood'];
//                 String size = userData['size'];
//
//                 appointmentWidgets.add(Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppThemeData.primaryColor,
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(profileImageUrl),
//                       ),
//                       subtitle: Text(
//                         'Age: $age',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       title: Text(
//                         userName,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       trailing: Text(
//                         time,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PatientProfilePage(
//                               userName: userName,
//                               age: age,
//                               profileImageUrl: profileImageUrl,
//                               email: email,
//                               phone: phone,
//                               place: place,
//                               gender: gender,
//                               blood: blood,
//                               size: size,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ));
//               }
//             }
//           }
//
//           return ListView(
//             children: appointmentWidgets,
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

class DayAfterTomorrowAppointmentsPage extends StatelessWidget {
  final BuildContext context; // Add the context parameter

  const DayAfterTomorrowAppointmentsPage({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dayAfterTomorrowDate = DateTime.now().add(Duration(days: 2));
    String formattedDayAfterTomorrowDate = dayAfterTomorrowDate.toIso8601String().split('T')[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Day After Tomorrow's Appointments",
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
                    .where('date', isEqualTo: formattedDayAfterTomorrowDate)
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
