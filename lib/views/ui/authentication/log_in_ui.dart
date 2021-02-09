import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickd_business/bloc/login_bloc.dart';
import 'package:quickd_business/utils/Constants.dart';
import 'package:quickd_business/views/animation/routes.dart';
import 'package:quickd_business/views/components/text_field_container.dart';
import 'package:quickd_business/views/ui/main/home_screen.dart';

loginUi(BuildContext context, Size size) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), topLeft: Radius.circular(40)),
      ),
      builder: (context) {
        return LoginScreen(
          size: size,
        );
      });
}

class LoginScreen extends StatefulWidget {
  final Size size;
  LoginScreen({Key key, this.size}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey();
  Size size;
  String email, password;
  bool showLoading = false;
  final bloc = LoginBloc();
  @override
  void initState() {
    size = widget.size;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
              child: SvgPicture.asset(
                "assets/images/login.svg",
                height: size.height * 0.25,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextFieldContainer(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Enter Email ID',
                      icon:
                          Icon(Icons.email_outlined, color: Colors.deepPurple),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                  onSaved: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Email Id';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Invalid Email id';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: TextFieldContainer(
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: 'Enter Password',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.deepPurple,
                      ),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter PassWord';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
            ),
            showLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    width: size.width,
                    margin: EdgeInsets.fromLTRB(32, 16, 32, 32),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      color: kPrimaryColor,
                      onPressed: () {
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          _validateAndLogIn();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.lock_open_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'SECURE LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ));
  }

  void _validateAndLogIn() {
    setState(() {
      showLoading = true;
      bloc.loginUser(email, password);
      bloc.loginStream.listen((event) {
        setState(() {
          showLoading = false;
        });
        Map<String, dynamic> _map = event;
        String msg = _map['msg'];
        if (_map.containsKey('verified')) {
          bool _verified = _map['verified'];
          if (!_verified) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Verification Email send'),
                    content: Text(
                        'A no reply email has been send to $email, click the link in it to verify your email'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'))
                    ],
                  );
                });
          } else {
            Navigator.of(context).pop();
            _goToHome();
          }
        } else {
          Fluttertoast.showToast(msg: msg);
        }
      });
    });
  }

  void _goToHome() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
          context, PageRoutes.fadeThrough(HomeScreen()), (route) => false);
    });
  }
}
