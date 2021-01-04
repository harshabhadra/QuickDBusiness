import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quickd_business/views/animation/routes.dart';
import 'package:quickd_business/views/ui/authentication/sign_up_ui.dart';
import 'package:quickd_business/views/ui/authentication/welcome_ui.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool show = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        show = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(context,
              PageRoutes.fadeThrough(WelcomeScreen()), (route) => false);
        });
      });
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
                      duration: Duration(seconds: 3),
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
