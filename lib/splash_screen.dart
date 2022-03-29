import 'package:flutter/material.dart';
import 'package:summiteagle/globals/access.dart';
import 'package:summiteagle/services/auth.dart';
import 'package:summiteagle/services/data_cacher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DataCacher _cacher = DataCacher.instance;
  final AuthService _authService = AuthService();
  @override
  void initState() {
    check();
    super.initState();
  }

  check() async {
    await _cacher.credentials.then((value) async {
      if (value != null) {
        await _authService
            .signIn(
          context,
          email: value.email,
          password: value.password,
          isRememberd: true,
        )
            .then((u) {
          if (u != null) {
            setState(() {
              loggedUser = u;
            });
            Navigator.pushReplacementNamed(context, '/landing_page');
          } else {
            Navigator.pushReplacementNamed(context, '/login_page');
          }
        });
      } else {
        await Future.delayed(const Duration(milliseconds: 1300));
        Navigator.pushReplacementNamed(context, '/login_page');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// LOGO
          Hero(
            tag: 'logo',
            child: Container(
              width: 120,
              height: 120,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: FittedBox(
                child: CircularProgressIndicator.adaptive(
                  value: 30,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
