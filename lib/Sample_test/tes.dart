// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../Theam/theme.dart';
// import '../User/u08_profile.dart';
// import '../User/u12_my_appointments.dart';
// import '../User/u13_my_prescriptions.dart';
// import '../User/u14_about.dart';
// import '../User/u15_whatsapp_support.dart';
// import '../login_page.dart'; // Import your login page or welcome screen
//
// class CustomDrawer extends StatelessWidget {
//   final String userId;
//
//   const CustomDrawer({super.key, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppThemeData.backgroundBlack,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const SizedBox(
//             height: 150,
//             child: DrawerHeader(
//               decoration: BoxDecoration(
//                 color: AppThemeData.primaryColor,
//               ),
//               child: Text(
//                 'Drawer Header',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//           ),
//           ListTile(
//             title: const Text(
//               'Appointments',
//               style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AppointmentDetailsPage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text(
//               'Previous Prescriptions',
//               style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MyPrescriptionsPage(userId: userId),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text(
//               'My Profile',
//               style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ProfilePage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text(
//               'Support',
//               style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
//             ),
//             onTap: () {},
//           ),
//           ListTile(
//             title: const Text(
//               'WhatsApp Support',
//               style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => WhatsappSupport(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text(
//               'About',
//               style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const AboutMePage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text(
//               'Logout',
//               style: TextStyle(color: AppThemeData.primaryColor, fontSize: 22),
//             ),
//             onTap: () async {
//               final shouldLogout = await showDialog<bool>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text('Logout Confirmation'),
//                     content: const Text('Are you sure you want to logout?'),
//                     actions: <Widget>[
//                       TextButton(
//                         child: const Text('Cancel'),
//                         onPressed: () {
//                           Navigator.of(context).pop(false);
//                         },
//                       ),
//                       TextButton(
//                         child: const Text('Logout'),
//                         onPressed: () {
//                           Navigator.of(context).pop(true);
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//
//               if (shouldLogout == true) {
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                       (route) => false,
//                 );
//               }
//             },
//           ),
//           // Add more list tiles for additional items in the drawer
//         ],
//       ),
//     );
//   }
// }
