// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:medi_care/User/u06.1_navigation_bar.dart';
// import '../Theam/theme.dart';
// import '../widget/text_form_field.dart';
// import 'd0_main_page.dart';
// import 'd1.2_sigin.dart';
//
// class DoctorLoginPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   DoctorLoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppThemeData.backgroundBlack,
//         title: const Text(
//           "Doctor login",
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
//           padding: const EdgeInsets.only(left: 11, right: 10),
//           child: Container(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               children: [
//
//                 const SizedBox(
//                   height: 200,
//                 ),
//                 CustomTextFormField(
//                   controller: emailController,
//                   hintText: 'Email Address',
//                   prefixIcon: Icons.email_outlined,
//                 ),
//                 CustomTextFormField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   prefixIcon: Icons.lock_outline,
//                 ),
//
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final authenticationInstance = FirebaseAuth.instance;
//
//                       try {
//                         final ref = await authenticationInstance
//                             .signInWithEmailAndPassword(
//                             email: emailController.text,
//                             password: passwordController.text);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Logged in successfully'),
//                             duration: Duration(seconds: 2), //  set duration
//                           ),
//                         );
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const DoctorNavigationBar(),
//                             ));
//                       } catch (e) {
//                         print(e);
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                             content: Text('Invalid email or password')));
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(11))),
//                       backgroundColor: AppThemeData.primaryColor,
//                     ),
//                     child: const Text(
//                       "LOG IN",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>  DoctorSiginPage(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     "Doctor register",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: AppThemeData.primaryColor,
//                       fontSize: 17,
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/widget/text_form_field.dart';
import 'd0_main_page.dart';
import 'd1.2_sigin.dart';

class DoctorLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DoctorLoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemeData.backgroundBlack,
        title: const Text(
          "Doctor login",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppThemeData.primaryColor),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 11, right: 10),
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final authenticationInstance = FirebaseAuth.instance;

                      try {
                        final ref = await authenticationInstance
                            .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);

                        // Retrieve user data from Firestore
                        final userData = await FirebaseFirestore.instance
                            .collection('Doctor')
                            .doc(ref.user!.uid)
                            .get();

                        // Check if user is a doctor
                        if (userData.exists) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Logged in successfully'),
                              duration: Duration(seconds: 2), //  set duration
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DoctorNavigationBar(),
                            ),
                          );
                        } else {
                          // User is not authorized to access doctor features
                          await authenticationInstance.signOut();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Access denied. Not a doctor.'),
                              duration: Duration(seconds: 2), //  set duration
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid email or password')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      backgroundColor: AppThemeData.primaryColor,
                    ),
                    child: const Text(
                      "LOG IN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => DoctorSiginPage(),
                //       ),
                //     );
                //   },
                //   child: const Text(
                //     "Doctor register",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       color: AppThemeData.primaryColor,
                //       fontSize: 17,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


