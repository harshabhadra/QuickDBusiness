import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickd_business/views/animation/routes.dart';
import 'package:quickd_business/views/ui/authentication/log_in_ui.dart';
import 'package:quickd_business/views/ui/authentication/sign_up_ui.dart';
import 'package:animations/animations.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xff7f4ac3),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/log_in_bg.png'),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 200.0,
                        width: 200.0,
                        child: Image.asset('assets/images/app_logo.png')),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Center(
                        child: Text(
                          'Business',
                          style: GoogleFonts.openSansCondensed(
                              textStyle: Theme.of(context).textTheme.headline3,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      color: Colors.deepPurple,
                      onPressed: () {
                        loginUi(context, MediaQuery.of(context).size);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'LOG IN',
                          style: GoogleFonts.openSans(
                              textStyle: Theme.of(context).textTheme.button,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  OpenContainer(
                      transitionType: ContainerTransitionType.fade,
                      transitionDuration: Duration(seconds: 1),
                      closedBuilder: (_, openContainer) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 32),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            color: Colors.white,
                            onPressed: () {
                              openContainer();
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Create Account',
                                  style: GoogleFonts.openSans(
                                      textStyle:
                                          Theme.of(context).textTheme.button,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      openBuilder: (_, closeContainer) {
                        return SignUpScreen();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
