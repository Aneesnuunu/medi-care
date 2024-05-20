// import 'package:flutter/material.dart';
// import 'package:intro_screen_onboarding_flutter/intro_app.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'u03_login_or_signup.dart';
// import '../controller/auth_provider.dart'; // Import the auth provider
//
// class OnBoarding extends StatelessWidget {
//   final List<Introduction> list = [
//     Introduction(
//       title: '',
//       subTitle:
//       'Welcome to our clinic appointment app! Easily book your appointments and manage your health with just a few taps.',
//       subTitleTextStyle: GoogleFonts.lato(
//         // color: AppThemeData.primaryColor,
//         fontSize: 20,
//       ),
//       imageUrl: 'assets/Images/logo.jpg',
//     ),
//     Introduction(
//       title: '',
//       subTitle:
//       'Never wait in long queues again! Our app lets you schedule appointments with our dedicated doctor conveniently.',
//       subTitleTextStyle: GoogleFonts.lato(
//         // color: AppThemeData.primaryColor,
//         fontSize: 20,
//       ),
//       imageUrl: 'assets/Images/logo.jpg',
//     ),
//     Introduction(
//       title: '',
//       subTitle:
//       'Your time is precious. Let our app simplify your appointment scheduling process. Get started today!',
//       subTitleTextStyle: GoogleFonts.lato(
//         // color: AppThemeData.primaryColor,
//         fontSize: 20,
//       ),
//       imageUrl: 'assets/Images/logo.jpg',
//     ),
//   ];
//
//    OnBoarding({super.key}); // Added named key parameter
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return IntroScreenOnboarding(
//       introductionList: list.map((intro) {
//         return Introduction(
//           title: intro.title,
//           subTitle: intro.subTitle,
//           subTitleTextStyle: intro.subTitleTextStyle,
//           imageUrl: intro.imageUrl,
//           imageWidth: screenWidth * 0.8, // Adjust the image width dynamically
//         );
//       }).toList(),
//       onTapSkipButton: () {
//         authProvider.setOnboardingCompleted(); // Update onboarding completion status
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const LogorSign(),
//           ), //MaterialPageRoute
//         );
//       },
//       // foregroundColor: Colors.red,
//       // backgroudColor: AppThemeData.backgroundBlack,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_care/User/u06_home_page.dart';
import 'package:provider/provider.dart';
import 'u03_login_or_signup.dart';
import '../controller/auth_provider.dart'; // Import the auth provider

class OnBoarding extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: '',
      subTitle:
      'Welcome to our clinic appointment app! Easily book your appointments and manage your health with just a few taps.',
      subTitleTextStyle: GoogleFonts.lato(
        // color: AppThemeData.primaryColor,
        fontSize: 20,
      ),
      imageUrl: 'assets/Images/logo.jpg',
    ),
    Introduction(
      title: '',
      subTitle:
      'Never wait in long queues again! Our app lets you schedule appointments with our dedicated doctor conveniently.',
      subTitleTextStyle: GoogleFonts.lato(
        // color: AppThemeData.primaryColor,
        fontSize: 20,
      ),
      imageUrl: 'assets/Images/logo.jpg',
    ),
    Introduction(
      title: '',
      subTitle:
      'Your time is precious. Let our app simplify your appointment scheduling process. Get started today!',
      subTitleTextStyle: GoogleFonts.lato(
        // color: AppThemeData.primaryColor,
        fontSize: 20,
      ),
      imageUrl: 'assets/Images/logo.jpg',
    ),
  ];

   OnBoarding({Key? key}) : super(key: key); // Added named key parameter

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final double screenWidth = MediaQuery.of(context).size.width;

    return IntroScreenOnboarding(
      introductionList: list.map((intro) {
        return Introduction(
          title: intro.title,
          subTitle: intro.subTitle,
          subTitleTextStyle: intro.subTitleTextStyle,
          imageUrl: intro.imageUrl,
          imageWidth: screenWidth * 0.8, // Adjust the image width dynamically
        );
      }).toList(),
      onTapSkipButton: () {
        authProvider.setOnboardingCompleted(); // Update onboarding completion status
        if (authProvider.isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(), // Navigate to HomePage
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LogorSign(), // Navigate to Login/Signup screen
            ),
          );
        }
      },
      // foregroundColor: Colors.red,
      // backgroudColor: AppThemeData.backgroundBlack,
    );
  }
}
