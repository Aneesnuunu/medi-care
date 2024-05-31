import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_care/User/u05_signin_screen.dart';
import 'package:medi_care/User/u06.1_navigation_bar.dart';
import 'package:medi_care/User/u5.1_pass_reset.dart';
import '../Theam/theme.dart';
import '../doctor/d1.1_login.dart';
import '../widget/text_form_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 300,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword(),));
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppThemeData.primaryColor,
                          fontSize: 17,
                        ),
                      ),
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
                    onPressed: () async {
                      final authenticationInstance = FirebaseAuth.instance;

                      try {
                        final ref = await authenticationInstance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Logged in successfully'),
                            duration: Duration(seconds: 2), //  set duration
                          ),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigationBar123(),
                            ));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid email or password')));
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SiginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "I haven't an account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppThemeData.primaryColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorLoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Doctor login",
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
    );
  }
}
