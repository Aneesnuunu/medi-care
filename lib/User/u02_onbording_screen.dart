import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:medi_care/User/u03_login_or_signup.dart';

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

   OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LogorSign(),
          ), //MaterialPageRoute
        );
      },
      // foregroundColor: Colors.red,
      // backgroudColor: AppThemeData.backgroundBlack,
    );
  }
}
