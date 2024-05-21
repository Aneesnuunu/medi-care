// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../Theam/theme.dart';
// import '../doctor/d5_patient_profile.dart';
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
//                             userName: userName,
//                             age: age,
//                             profileImageUrl: profileImageUrl,
//                             email: email,
//                             phone: phone,
//                             place: place,
//                             gender: gender,
//                             blood: blood,
//                             size: size,
//                             date: date,
//                             appointmentId: appointmentId,
//                             userId: userId,
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