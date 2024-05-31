// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:medi_care/User/u04_login_screen.dart';
//
// import '../Theam/theme.dart';
// import '../widget/text_form_field.dart';
//
// class SiginPage extends StatefulWidget {
//   const SiginPage({super.key});
//
//   @override
//   _SiginPageState createState() => _SiginPageState();
// }
//
// class _SiginPageState extends State<SiginPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController genderController = TextEditingController();
//   final TextEditingController bloodgroupController = TextEditingController();
//   final TextEditingController heightweightController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController smsCodeController = TextEditingController();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   String _verificationId = '';
//   bool _isPhoneVerified = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SingleChildScrollView(
//           reverse: true,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 11, right: 10),
//             child: Container(
//               padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).viewInsets.bottom),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   CustomTextFormField(
//                     controller: nameController,
//                     hintText: 'Name',
//                     prefixIcon: Icons.person,
//                   ),
//                   CustomTextFormField(
//                     controller: emailController,
//                     hintText: 'Email Address',
//                     prefixIcon: Icons.email_outlined,
//                   ),
//                   CustomTextFormField(
//                     controller: passwordController,
//                     hintText: 'Password',
//                     prefixIcon: Icons.lock_outline,
//                   ),
//                   CustomTextFormField(
//                     controller: ageController,
//                     hintText: 'Age',
//                     prefixIcon: Icons.calendar_today_outlined,
//                   ),
//                   CustomTextFormField(
//                     controller: placeController,
//                     hintText: 'Place',
//                     prefixIcon: Icons.location_on_outlined,
//                   ),
//                   CustomTextFormField(
//                     controller: genderController,
//                     hintText: 'Gender',
//                     prefixIcon: Icons.wc_outlined,
//                   ),
//                   CustomTextFormField(
//                     controller: bloodgroupController,
//                     hintText: 'Blood group',
//                     prefixIcon: Icons.bloodtype_outlined,
//                   ),
//                   CustomTextFormField(
//                     controller: heightweightController,
//                     hintText: 'Height/Weight',
//                     prefixIcon: Icons.format_size_outlined,
//                   ),
//                   CustomTextFormField(
//                     controller: phoneController,
//                     hintText: 'Phone',
//                     prefixIcon: Icons.phone,
//                   ),
//                   const SizedBox(height: 20),
//                   if (!_isPhoneVerified) ...[
//                     CustomTextFormField(
//                       controller: smsCodeController,
//                       hintText: 'Enter SMS Code',
//                       prefixIcon: Icons.sms,
//                     ),
//                     ElevatedButton(
//                       onPressed: () => _verifyPhoneNumber(),
//                       child: const Text('Verify Phone Number'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () => _signInWithPhoneNumber(),
//                       child: const Text('Submit Verification Code'),
//                     ),
//                   ],
//                   const SizedBox(height: 20),
//                   if (_isPhoneVerified)
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           final authenticationInstance = FirebaseAuth.instance;
//                           final dbInstance = FirebaseFirestore.instance;
//
//                           try {
//                             final ref = await authenticationInstance
//                                 .createUserWithEmailAndPassword(
//                                 email: emailController.text,
//                                 password: passwordController.text);
//
//                             var userId = ref.user!.uid;
//
//                             var data = {
//                               "name": nameController.text,
//                               "email": emailController.text,
//                               "password": passwordController.text,
//                               "age": ageController.text,
//                               "place": placeController.text,
//                               "gender": genderController.text,
//                               "blood": bloodgroupController.text,
//                               "size": heightweightController.text,
//                               "phone": phoneController.text,
//                             };
//
//                             var dbRef = dbInstance
//                                 .collection("User")
//                                 .doc(userId)
//                                 .set(data);
//
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Registration successfully'),
//                                 duration: Duration(seconds: 2),
//                               ),
//                             );
//
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginPage(),
//                               ),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Error: $e'),
//                               ),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: const RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(11))),
//                           backgroundColor: AppThemeData.primaryColor,
//                         ),
//                         child: const Text(
//                           "Create an Account",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   const SizedBox(height: 30),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LoginPage(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       "I have already an account",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: AppThemeData.primaryColor,
//                         fontSize: 17,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _verifyPhoneNumber() async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneController.text,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await _auth.signInWithCredential(credential);
//           setState(() {
//             _isPhoneVerified = true;
//           });
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Verification failed. Error: ${e.message}')),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           setState(() {
//             _verificationId = verificationId;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Verification code sent.')),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           setState(() {
//             _verificationId = verificationId;
//           });
//         },
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to Verify Phone Number: $e')),
//       );
//     }
//   }
//
//   Future<void> _signInWithPhoneNumber() async {
//     try {
//       final PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: smsCodeController.text,
//       );
//
//       await _auth.signInWithCredential(credential);
//       setState(() {
//         _isPhoneVerified = true;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Phone number verified.')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to sign in: $e')),
//       );
//     }
//   }
// }

//*************************//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_care/User/u04_login_screen.dart';

import '../Theam/theme.dart';
import '../widget/text_form_field.dart';

class SiginPage extends StatelessWidget {
  const SiginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController placeController = TextEditingController();
    final TextEditingController genderController = TextEditingController();
    final TextEditingController bloodgroupController = TextEditingController();
    final TextEditingController heightweightController =
        TextEditingController();

    final TextEditingController phoneController = TextEditingController();

    return SafeArea(
      child: Scaffold(
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
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: nameController,
                    hintText: 'Name',
                    prefixIcon: Icons.person,
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
                  CustomTextFormField(
                    controller: ageController,
                    hintText: 'Age',
                    prefixIcon: Icons.calendar_today_outlined,
                  ),
                  CustomTextFormField(
                    controller: placeController,
                    hintText: 'Place',
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  CustomTextFormField(
                    controller: genderController,
                    hintText: 'Gender',
                    prefixIcon: Icons.wc_outlined,
                  ),
                  CustomTextFormField(
                    controller: bloodgroupController,
                    hintText: 'Blood group',
                    prefixIcon: Icons.bloodtype_outlined,
                  ),
                  CustomTextFormField(
                    controller: heightweightController,
                    hintText: 'Height/Weight',
                    prefixIcon: Icons.format_size_outlined,
                  ),
                  CustomTextFormField(
                    controller: phoneController,
                    hintText: 'Phone',
                    prefixIcon: Icons.phone,
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
                        final dbInstance = FirebaseFirestore.instance;

                        try {
                          final ref = await authenticationInstance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);

                          var userId = ref.user!.uid;

                          var data = {
                            "name": nameController.text,
                            "email": emailController.text,
                            "password": passwordController.text,
                            "age": ageController.text,
                            "place": placeController.text,
                            "gender": genderController.text,
                            "blood": bloodgroupController.text,
                            "size": heightweightController.text,
                            "phone": phoneController.text,
                          };

                          var dbRef = dbInstance
                              .collection("User")
                              .doc(userId)
                              .set(data);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registration successfully'),
                              duration: Duration(
                                  seconds: 2), // Optional: set duration
                            ),
                          );

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        } catch (e) {
                          // print(e);
                        }
                      },

                      ///////////////////////
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                        backgroundColor: AppThemeData.primaryColor,
                      ),
                      child: const Text(
                        "Create an Account",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "I have already an account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppThemeData.primaryColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
