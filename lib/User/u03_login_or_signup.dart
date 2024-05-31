// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:medi_care/Theam/theme.dart';
// import 'package:medi_care/User/u02_onbording_screen.dart';
// import 'package:medi_care/User/u04_login_screen.dart';
// import 'package:medi_care/User/u05_signin_screen.dart';
// import 'package:provider/provider.dart';
// import '../controller/auth_provider.dart'; // Import the auth provider
//
// class LogorSign extends StatelessWidget {
//   const LogorSign({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           const SizedBox(
//             height: 100,
//           ),
//           Container(
//             alignment: Alignment.topLeft,
//             margin: const EdgeInsets.only(left: 15),
//             child: Text(
//               "Welcome to \n MediCare",
//               style: GoogleFonts.pacifico(
//                 fontSize: screenWidth * 0.1, // Adjust font size dynamically
//                 color: AppThemeData.primaryColor,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Container(
//             child: Lottie.asset(
//               "animation/Animation - 1714577158136.json",
//               width: screenWidth * 1.0, // Adjust Lottie width dynamically
//             ),
//           ),
//           const SizedBox(
//             height: 160,
//           ),
//           Row(
//             children: [
//               SizedBox(
//                 width: screenWidth * 0.5,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SiginPage(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: const RoundedRectangleBorder(),
//                     backgroundColor: AppThemeData.backgroundBlack,
//                   ),
//                   child: Text(
//                     "SIGN UP",
//                     style: GoogleFonts.lato(
//                       textStyle: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: screenWidth * 0.5,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (authProvider.onboardingCompleted) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LoginPage(),
//                         ),
//                       );
//                     } else {
//                       // Navigate to OnBoarding if onboarding not completed
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => OnBoarding(),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: const RoundedRectangleBorder(),
//                     backgroundColor: AppThemeData.primaryColor,
//                   ),
//                   child: Text(
//                     "LOG IN",
//                     style: GoogleFonts.lato(
//                       textStyle: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:medi_care/User/u02_onbording_screen.dart';
import 'package:medi_care/User/u04_login_screen.dart';
import 'package:medi_care/User/u05_signin_screen.dart';
import 'package:provider/provider.dart';
import '../controller/auth_provider.dart';

class LogorSign extends StatelessWidget {
  const LogorSign({super.key});


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 15),
            child: Text(
              "Welcome to \n MediCare",
              style: GoogleFonts.pacifico(
                fontSize: screenWidth * 0.1,
                color: AppThemeData.primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            child: Lottie.asset(
              "animation/Animation - 1714577158136.json",
              width: screenWidth * 1.0,
            ),
          ),
          const SizedBox(
            height: 160,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.5,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SiginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: AppThemeData.backgroundBlack,
                  ),
                  child: Text(
                    "SIGN UP",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.5,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (authProvider.onboardingCompleted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnBoarding(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: AppThemeData.primaryColor,
                  ),
                  child: Text(
                    "LOG IN",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
