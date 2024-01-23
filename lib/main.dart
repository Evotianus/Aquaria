import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:aquaria/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Colors.white, // Set white as the primary color
        textTheme: GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme),
      ),
      home: AnimatedSplashScreen(
        splash: "assets/logo.png",
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color(0xff00B4ED),
        // splashIconSize:
      ),
    );
  }
}
