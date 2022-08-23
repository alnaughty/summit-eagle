import 'package:flutter/material.dart';
import 'package:summiteagle/globals/access.dart';
import 'package:summiteagle/globals/widget.dart';
import 'package:summiteagle/services/auth.dart';
import 'package:summiteagle/services/data_cacher.dart';
import 'package:summiteagle/services/firestore/admin.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await check();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final Admin admin = Admin();
  check() async {
    print("CHECK");
    await _cacher.credentials.then((value) async {
      if (value != null) {
        await _authService
            .signIn(
          context,
          email: value.email,
          password: value.password,
          isRememberd: true,
        )
            .then((u) async {
          if (u != null) {
            setState(() {
              loggedUser = u;
            });
            await admin.isAdmin();
            Navigator.pushReplacementNamed(context, '/landing_page');
          } else {
            Navigator.pushReplacementNamed(context, '/login_page');
          }
        });
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.pushReplacementNamed(context, '/login_page');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// LOGO
          Padding(
            padding: const EdgeInsets.all(20),
            child: logo,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: FittedBox(
                child: CircularProgressIndicator.adaptive(
                  // value: 30,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation(Colors.orange),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
