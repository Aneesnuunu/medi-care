// import 'package:flutter/material.dart';
// import 'package:medi_care/doctor/u15_prescription_sheet.dart';
// import '../Theam/theme.dart';
//
// class PatientProfilePage extends StatelessWidget {
//   final String userName;
//   final String age;
//   final String profileImageUrl;
//   final String email;
//   final String phone;
//   final String place;
//   final String gender;
//   final String blood;
//   final String size;
//
//   PatientProfilePage({
//     required this.userName,
//     required this.age,
//     required this.profileImageUrl,
//     required this.email,
//     required this.phone,
//     required this.place,
//     required this.gender,
//     required this.blood,
//     required this.size,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppThemeData.backgroundBlack,
//         title: const Text(
//           "Patient Profile",
//           style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: AppThemeData.primaryColor),
//         ),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         reverse: true,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Center(
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     radius: 70,
//                     backgroundImage: profileImageUrl.isNotEmpty
//                         ? NetworkImage(profileImageUrl)
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ProfileField(
//                       label: "Name",
//                       value: userName,
//                     ),
//                     ProfileField(
//                       label: "Email Address",
//                       value: email,
//                     ),
//                     ProfileField(
//                       label: "Age",
//                       value: age,
//                     ),
//                     ProfileField(
//                       label: "Place",
//                       value: place,
//                     ),
//                     ProfileField(
//                       label: "Gender",
//                       value: gender,
//                     ),
//                     ProfileField(
//                       label: "Blood Group",
//                       value: blood,
//                     ),
//                     ProfileField(
//                       label: "Size",
//                       value: size,
//                     ),
//                     ProfileField(
//                       label: "Phone",
//                       value: phone,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PrescriptionSheet(
//                             name: userName,
//                             age: age,
//                             place: place,
//                             date: DateTime.now().toIso8601String(),
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(11))),
//                       backgroundColor: AppThemeData.primaryColor,
//                     ),
//                     child: const Text(
//                       "Start Consultation",
//                       style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ProfileField extends StatelessWidget {
//   final String label;
//   final String value;
//
//   ProfileField({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12.0),
//       padding: const EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//         color: AppThemeData.primaryColor.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Row(
//         children: [
//           Text(
//             "$label :  ",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 color: AppThemeData.primaryColor),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/material.dart';
import 'package:medi_care/doctor/u15_prescription_sheet.dart';
import '../Theam/theme.dart';

class PatientProfilePage extends StatelessWidget {
  final String userName;
  final String age;
  final String profileImageUrl;
  final String email;
  final String phone;
  final String place;
  final String gender;
  final String blood;
  final String size;
  final String date;
  final String appointmentId; // Add appointmentId as a parameter
  final String userId;
  PatientProfilePage({
    required this.userName,
    required this.age,
    required this.profileImageUrl,
    required this.email,
    required this.phone,
    required this.place,
    required this.gender,
    required this.blood,
    required this.size,
    required this.date,
    required this.appointmentId, // Initialize appointmentId
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemeData.backgroundBlack,
        title: const Text(
          "Patient Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppThemeData.primaryColor,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70,
                    backgroundImage: profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileField(
                      label: "Name",
                      value: userName,
                    ),
                    ProfileField(
                      label: "Email",
                      value: email,
                    ),
                    ProfileField(
                      label: "Age",
                      value: age,
                    ),
                    ProfileField(
                      label: "Place",
                      value: place,
                    ),
                    ProfileField(
                      label: "Gender",
                      value: gender,
                    ),
                    ProfileField(
                      label: "Blood Group",
                      value: blood,
                    ),
                    ProfileField(
                      label: "Size",
                      value: size,
                    ),
                    ProfileField(
                      label: "Phone",
                      value: phone,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the PrescriptionSheet page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrescriptionSheet(
                            name: userName,
                            age: age,
                            place: place,
                            date: date,
                            appointmentId: appointmentId, // Pass appointment ID
                            userId: userId,

                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(11),
                        ),
                      ),
                      backgroundColor: AppThemeData.primaryColor,
                    ),
                    child: const Text(
                      "Start Consultation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppThemeData.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Text(
            "$label :  ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppThemeData.primaryColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
