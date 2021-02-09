import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:quickd_business/bloc/bloc.dart';
import 'package:quickd_business/model/user_details.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegistrationBloc extends Bloc {
  final _controller = StreamController<bool>();

  Stream get userStream => _controller.stream;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void completeRegistration(UserDetails userDetails, File _image) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('sellerDocs')
        .child('${Path.basename(_image.path)}');

    firebase_storage.UploadTask uploadTask = ref.putFile(_image);
    await uploadTask.whenComplete(() {
      _downLoadUrl(userDetails, ref);
    });
  }

  void _downLoadUrl(
      UserDetails userDetails, firebase_storage.Reference ref) async {
    await ref.getDownloadURL().then((value) {
      userDetails.setIdUrl = value;
      registerUser(userDetails);
    });
  }

  void registerUser(UserDetails userDetails) {
    CollectionReference users = firestore.collection('SellerDetails');

    users.add({
      'email': userDetails.email,
      'phone': userDetails.phone,
      'name': userDetails.name,
      'shopName': userDetails.shopName,
      'shopAddress': userDetails.shopAddress,
      'idUrl': userDetails.idUrl,
      'businessTypes': FieldValue.arrayUnion(userDetails.businessTypes),
      'isVerified': userDetails.isVerified
    }).then((value) {
      print("user added ${value.id}, value : ${value.toString()}");

      _controller.sink.add(true);
    }).catchError((error) {
      print("Failed registration : ${error.toString()}");
      _controller.sink.add(false);
    });
  }

  @override
  void dispose() {
    _controller.close();
  }
}
