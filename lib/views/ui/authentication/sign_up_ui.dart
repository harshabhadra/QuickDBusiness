import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickd_business/views/components/text_field_container.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create Account',
          style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.headline5,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
        leading: Icon(
          Icons.close_outlined,
          color: Colors.black,
          
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.login_outlined
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 32),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                          border:
                              Border.all(color: Colors.deepPurple, width: 2.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset('assets/images/restaurant.svg'),
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
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
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
                          icon: Icon(
                            Icons.lock,
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
                          hintText: 'Confirm Password',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.deepPurple,
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
