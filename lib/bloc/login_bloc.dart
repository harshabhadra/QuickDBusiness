import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:quickd_business/bloc/bloc.dart';

class LoginBloc extends Bloc {
  final _controller = StreamController<Map<String, dynamic>>();

  Stream get loginStream => _controller.stream;

  void loginUser(String email, String password) async {
    Map<String, dynamic> _map = Map();
    var box = Hive.box('docs');

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;

      if (!user.emailVerified) {
        await user.sendEmailVerification();
        _map['verified'] = false;
        _map['msg'] = 'Email not Verified';
      } else {
        _map['verified'] = true;
        _map['msg'] = 'Logged In Successfully';
        box.put('email', email);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _map['msg'] = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _map['msg'] = 'Wrong password provided for that user.';
      } else {
        _map['msg'] = e.message;
      }
    }
    _controller.sink.add(_map);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
