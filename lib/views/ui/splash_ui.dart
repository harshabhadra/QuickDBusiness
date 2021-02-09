import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quickd_business/views/animation/routes.dart';
import 'package:quickd_business/views/ui/authentication/sign_up_ui.dart';
import 'package:quickd_business/views/ui/authentication/welcome_ui.dart';
import 'package:quickd_business/views/ui/main/home_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool show = false;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            show = true;
          });
        });
        Future.delayed(const Duration(milliseconds: 1500), () {
          setState(() {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(context,
                  PageRoutes.fadeThrough(WelcomeScreen()), (route) => false);
            });
          });
        });
      } else {
        print('User is signed in!');
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            show = true;
          });
        });
        Future.delayed(const Duration(milliseconds: 1500), () {
          setState(() {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(context,
                  PageRoutes.fadeThrough(HomeScreen()), (route) => false);
            });
          });
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 1000),
                      height: show ? 200 : 0,
                      width: show ? 200.0 : 0,
                      child: Image.asset('assets/images/app_logo.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
