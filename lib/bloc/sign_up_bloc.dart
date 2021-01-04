import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickd_business/bloc/bloc.dart';
import 'package:quickd_business/model/error_model.dart';

class SignUpBloc extends Bloc {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _controller = StreamController<dynamic>.broadcast();
  Map<String, dynamic> responseMap = Map();
  Map<String, dynamic> verifyMap = Map();

  Stream<dynamic> get userStream => _controller.stream.asBroadcastStream();

  void createAccount(String email, String password) async {
    await _signUp(email, password);
  }

  Future<void> _signUp(String email, String password) async {
    responseMap.clear();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      sendVerificationEmail(userCredential);
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ErrorModel errorModel = ErrorModel(
            errorType: ErrorType.FIREBASE_AUTH,
            errorMessage: 'The password provided is too weak.',
            description: e.credential.toString());
        responseMap['error'] = errorModel;
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ErrorModel errorModel = ErrorModel(
            errorType: ErrorType.FIREBASE_AUTH,
            errorMessage: 'The account already exists for that email.',
            description: e.credential.toString());
        responseMap['error'] = errorModel;
      } else {
        print('Firebase auth exception: ${e.message}');
        ErrorModel errorModel = ErrorModel(
            errorType: ErrorType.FIREBASE_AUTH,
            errorMessage: e.message,
            description: e.credential.toString());
        responseMap['error'] = errorModel;
      }
      _controller.sink.add(responseMap);
    } catch (e) {
      print("sign up auth error " + e.toString());
    }
  }

  //Send verification email
  void sendVerificationEmail(UserCredential userCredential) async {
    try {
      User user = userCredential.user;
      await user.sendEmailVerification();
      responseMap['user'] = userCredential;
      _controller.sink.add(responseMap);
    } catch (e) {
      print('Error sending verification email: ' + e.toString());
      ErrorModel errorModel = ErrorModel(
          errorType: ErrorType.UNKNOWN,
          errorMessage: e.toString(),
          description: '');
      responseMap['error'] = errorModel;
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
