import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_care/provider/appointment_provider.dart';
import 'package:medi_care/provider/login.dart';
import 'package:provider/provider.dart';
import 'Model/u08_profile_page_model.dart';
import 'User/u04_login_screen.dart';
import 'controller/auth_provider.dart';
import 'Theam/theme.dart';
import 'User/u01_splash_screen.dart';
import 'doctor/d1.1_login.dart';
import 'doctor/d4_profile.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentsProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) =>ProfilePageModel ()),





      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: AppThemeData.backgroundBlack,
          appBarTheme: const AppBarTheme(backgroundColor: AppThemeData.backgroundBlack),
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginPage(), // SplashScreen will navigate based on login state
      ),
    );
  }
}
