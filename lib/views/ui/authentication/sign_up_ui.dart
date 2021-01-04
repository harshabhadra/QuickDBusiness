import 'package:animations/animations.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quickd_business/bloc/sign_up_bloc.dart';
import 'package:quickd_business/model/error_model.dart';
import 'package:quickd_business/utils/Constants.dart';
import 'package:quickd_business/views/components/text_field_container.dart';
import 'package:quickd_business/views/ui/authentication/registration_ui.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  String email, phone, password, cPassword;
  var numberFormatter = MaskTextInputFormatter(mask: ('### ### ####'));
  SignUpBloc bloc;
  bool showLoading;
  bool showErrorText;
  ErrorModel _errorModel;
  UserCredential _userCredential;

  @override
  void initState() {
    bloc = SignUpBloc();
    showLoading = false;
    showErrorText = false;
    super.initState();
  }

  void _validateAndSignUp(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      bloc.createAccount(email, password);
      setState(() {
        showLoading = true;
        showErrorText = false;
        bloc.userStream.listen((event) {
          Map<String, dynamic> map = Map();
          map = event;
          if (map.containsKey('error')) {
            _errorModel = map['error'];
            setState(() {
              showErrorText = true;
              showLoading = false;
            });
          } else if (map.containsKey('user')) {
            _userCredential = map['user'];
            print('User email: ${_userCredential.user.email}');
            _showVerifyEmailDialog(_userCredential.user.email);
            setState(() {
              showErrorText = false;
              showLoading = false;
            });
          }
        });
      });
    }
  }

  Future<dynamic> _showVerifyEmailDialog(String email) {
    return showDialog(
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
                    _goToRegistration();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  void _goToRegistration() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RegistrationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Create Account',
          style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.headline5,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: OpenContainer(
        
        closedBuilder: (_, openContainer) {
          return FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              // if (_key.currentState.validate()) {
              //   print('All values are correct');
              //   _key.currentState.save();
              //   _validateAndSignUp(email, password);
              // }
              // _goToRegistration();
              openContainer();
            },
            child: Container(
              child: Icon(
                Icons.login_outlined,
                color: kPrimaryColor,
              ),
            ),
          );
        },
        openBuilder: (_, closeContainer) {
          return RegistrationScreen();
        },
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        transitionDuration: Duration(milliseconds: 1000),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: kPrimaryColor,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/sign_up_bg.png'),
                      fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 24),
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90)),
                              border: Border.all(
                                  color: Colors.deepPurple, width: 2.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                                'assets/images/restaurant.svg'),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: TextFieldContainer(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Enter Email ID',
                                icon: Icon(Icons.email_outlined,
                                    color: Colors.deepPurple),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
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
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [numberFormatter],
                          maxLength: 12,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Mobile Number';
                            } else if (value.replaceAll(' ', '').length < 10) {
                              return 'Enter Valid Mobile Number';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              phone = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Mobile Number',
                              helperText: 'Eg: 999 999 99999',
                              icon: Icon(
                                Icons.phone_android_outlined,
                                color: Colors.deepPurple,
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              hintText: 'Enter Password',
                              helperText: 'min length:  6 or more characters',
                              icon: Icon(
                                Icons.lock,
                                color: Colors.deepPurple,
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
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
                      Center(
                          child: showLoading
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                )
                              : Container()),
                      showErrorText
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _errorModel.errorMessage,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
