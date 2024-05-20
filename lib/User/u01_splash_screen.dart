// import 'package:flutter/material.dart';
// import 'package:medi_care/Theam/theme.dart';
// import 'package:provider/provider.dart';
// import '../controller/auth_provider.dart';
// import 'u02_onbording_screen.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//
//     // Set duration to 2 seconds
//     Future.delayed(const Duration(seconds: 2), () {
//       // Determine where to navigate based on login state
//       if (authProvider.isLoggedIn) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => OnBoarding()),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => OnBoarding()),
//         );
//       }
//     });
//
//     return Scaffold(
//       backgroundColor: AppThemeData.primaryColor,
//       body: Center(
//         child: SizedBox(
//           height: 200,
//           width: 200,
//           child: Image.asset('assets/Images/logo.jpg'),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/User/u06_home_page.dart';
import 'package:provider/provider.dart';
import '../controller/auth_provider.dart';
import 'u02_onbording_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Set duration to 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      // Determine where to navigate based on login state
      if (authProvider.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoarding()), // Navigate to OnBoarding screen
        );
      }
    });

    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset('assets/Images/logo.jpg'),
        ),
      ),
    );
  }
}
