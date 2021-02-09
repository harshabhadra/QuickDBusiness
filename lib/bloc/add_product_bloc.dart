import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:quickd_business/bloc/bloc.dart';
import 'package:quickd_business/model/product_model.dart';

class AddProductBloc extends Bloc {
  final _controller = StreamController<bool>.broadcast();
  final _uController = StreamController<bool>.broadcast();

  Stream get uploadStream => _controller.stream.asBroadcastStream();
  Stream get updateStream => _uController.stream.asBroadcastStream();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void uploadProduct(Product product, File _image) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products')
        .child('${Path.basename(_image.path)}');
    firebase_storage.UploadTask uploadTask = ref.putFile(_image);
    await uploadTask.whenComplete(() {
      _downLoadUrl(product, ref);
    });
  }

  void _downLoadUrl(Product product, firebase_storage.Reference ref) async {
    await ref.getDownloadURL().then((value) {
      product.imgUrl = value;
      _completeUpload(product);
    });
  }

  void _completeUpload(Product product) {
    CollectionReference productRef = firestore.collection('Products');
    productRef.add({
      'category': product.category,
      'productName': product.productName,
      'productDes': product.productDes,
      'price': product.price,
      'sellPrice': product.sellPrice,
      'imgUrl': product.imgUrl,
      'shop': product.restaurant,
      'rating': product.rating,
      'isAvailable': product.isAvailable
    }).then((value) {
      print("product added ${value.id}, value : ${value.toString()}");
      _controller.sink.add(true);
    }).catchError((error) {
      print("Failed to add product : ${error.toString()}");
      _controller.sink.add(false);
    });
  }

  void updateProduct(
      Product product, bool changeImage, File _image, String docId) async {
    if (!changeImage) {
      _updateProductDetails(product, docId);
    } else {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('products')
          .child('${Path.basename(_image.path)}');
      firebase_storage.UploadTask uploadTask = ref.putFile(_image);
      await uploadTask.whenComplete(() {
        _downLoadUpdateUrl(product, docId, ref);
      });
    }
  }

  void _downLoadUpdateUrl(
      Product product, String docId, firebase_storage.Reference ref) async {
    await ref.getDownloadURL().then((value) {
      product.imgUrl = value;
      _updateProductDetails(product, docId);
    });
  }

  void _updateProductDetails(Product product, String docId) {
    firestore.collection('Products').doc(docId).update({
      'category': product.category,
      'productName': product.productName,
      'productDes': product.productDes,
      'price': product.price,
      'sellPrice': product.sellPrice,
      'imgUrl': product.imgUrl,
      'shop': product.restaurant,
      'rating': product.rating,
      'isAvailable': product.isAvailable
    }).whenComplete(() => _uController.sink.add(true))
      ..catchError((error) {
        print("Failed to update Product" + error.toString());
        _uController.sink.add(false);
      });
  }

  @override
  void dispose() {
    _controller.close();
    _uController.close();
  }
}
