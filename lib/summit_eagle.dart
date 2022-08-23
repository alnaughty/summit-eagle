import 'package:flutter/material.dart';
import 'package:summiteagle/globals/app.dart';
import 'package:summiteagle/splash_screen.dart';
import 'package:summiteagle/views/auth/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:summiteagle/views/auth/register_page.dart';
import 'package:summiteagle/views/landing_page.dart';

class SummitEagle extends StatelessWidget {
  const SummitEagle({Key? key}) : super(key: key);
  static final AppConfig config = AppConfig();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEAF',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: config.orange,
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: config.black.withOpacity(.5),
          labelColor: config.black,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: config.black,
          ),
          titleTextStyle: AppBarTheme.of(context).titleTextStyle?.copyWith(
                color: config.black,
              ),
          backgroundColor: Colors.white,
        ),
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
