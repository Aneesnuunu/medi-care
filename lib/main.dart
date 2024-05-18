import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_care/widget/time_slot.dart';


import 'Sample_test/tes.dart';
import 'Theam/theme.dart';
import 'User/u01_splash_screen.dart';

import 'User/u04_login_screen.dart';
import 'User/u05_signin_screen.dart';
import 'User/u06.1_navigation_bar.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppThemeData.backgroundBlack,
        appBarTheme: const AppBarTheme(backgroundColor:AppThemeData.backgroundBlack ),
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   LoginPage(),
    );
  }
}
