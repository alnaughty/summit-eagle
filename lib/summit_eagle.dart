import 'package:flutter/material.dart';
import 'package:summiteagle/splash_screen.dart';
import 'package:summiteagle/views/auth/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:summiteagle/views/auth/register_page.dart';
import 'package:summiteagle/views/landing_page.dart';

class SummitEagle extends StatelessWidget {
  const SummitEagle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Summit Eagle Accounting and Finance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Poppins",
      ),
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/login_page":
            return PageTransition(
              child: const LoginPage(),
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
              type: PageTransitionType.bottomToTop,
            );
          case "/register_page":
            return PageTransition(
              child: const RegisterPage(),
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
              type: PageTransitionType.bottomToTop,
            );
          case "/splash_screen":
            return PageTransition(
              child: const SplashScreen(),
              type: PageTransitionType.fade,
            );
          case "/landing_page":
            return PageTransition(
              child: LandingPage(),
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
              type: PageTransitionType.bottomToTop,
            );
          default:
            return PageTransition(
              child: const SplashScreen(),
              type: PageTransitionType.fade,
            );
        }
      },
    );
  }
}
