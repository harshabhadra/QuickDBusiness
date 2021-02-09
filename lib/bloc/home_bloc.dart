import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickd_business/bloc/bloc.dart';

class HomeBloc extends Bloc {
  final _controller = StreamController<QuerySnapshot>();

  Stream<QuerySnapshot> get userStream => _controller.stream;

  void getUserInfo(String email) async {
    // FirebaseFirestore.instance
    //     .collection('SellerDetails')
    //     .doc(documentId)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Document exists on the database');
    //     print('shop name: ${documentSnapshot.data()['shopName']}');
    //     _controller.sink.add(documentSnapshot);
    //   }
    // });

    await FirebaseFirestore.instance
        .collection('SellerDetails')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      QuerySnapshot docs = value;
      _controller.add(docs);
    });
  }

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
  }
}
