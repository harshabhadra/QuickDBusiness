import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickd_business/bloc/add_product_bloc.dart';
import 'package:quickd_business/model/product_model.dart';
import 'package:quickd_business/model/user_details.dart';
import 'package:quickd_business/utils/Constants.dart';

class AddProductScreen extends StatefulWidget {
  final UserDetails userDetails;
  final Product product;
  final String docId;
  AddProductScreen(
      {Key key, @required this.userDetails, this.product, this.docId})
      : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String _categoryValue;
  GlobalKey<FormState> _key = GlobalKey();
  String _productName, _productDescription, _actualPrice, _sellPrice, _imgUrl;
  List<String> _categories = List();
  File _image;
  final picker = ImagePicker();
  bool isImageSelected = false;
  Product _product;
  final bloc = AddProductBloc();
  bool isUpdate;

  @override
  void initState() {
    if (widget.product != null) {
      isUpdate = true;
      _categories = [widget.product.category];
      _categoryValue = widget.product.category;
    } else {
      isUpdate = false;
      _categories = widget.userDetails.businessTypes;
      _categoryValue = widget.userDetails.businessTypes[0];
    }
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isImageSelected = true;
      } else {
        isImageSelected = false;
        print('No image selected.');
        Fluttertoast.showToast(msg: 'Image Not Picked');
      }
    });
  }

  void _uploadProduct() {
    if (_image == null) {
      Fluttertoast.showToast(msg: 'Upload Product Image');
    } else {
      BuildContext dialogContext;
      Dialog _loadingDialog = Dialog(
        child: Container(
          height: 90,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          )),
        ),
      );
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            dialogContext = context;
            return _loadingDialog;
          });
      _product = Product(
          category: _categoryValue,
          productName: _productName,
          productDes: _productDescription,
          price: _actualPrice,
          sellPrice: _sellPrice,
          imgUrl: "",
          restaurant: widget.userDetails.shopName,
          rating: "",
          isAvailable: true);

      bloc.uploadProduct(_product, _image);
      bloc.uploadStream.listen((event) {
        setState(() {
          Navigator.pop(dialogContext);
          bool isUploaded = event;
          if (isUploaded) {
            _showResultDialog('Product Added Successfully');
          } else {
            _showResultDialog('Failed To Add Product');
          }
        });
      });
    }
  }

  void _updateProduct() {
    BuildContext dialogContext;
    Dialog _loadingDialog = Dialog(
      child: Container(
        height: 90,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        )),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          dialogContext = context;
          return _loadingDialog;
        });
    _product = Product(
        category: _categoryValue,
        productName: _productName,
        productDes: _productDescription,
        price: _actualPrice,
        sellPrice: _sellPrice,
        imgUrl: widget.product.imgUrl,
        restaurant: widget.userDetails.shopName,
        rating: "",
        isAvailable: true);

    bloc.updateProduct(_product, isImageSelected, _image, widget.docId);
    bloc.updateStream.listen((event) {
      setState(() {
        Navigator.pop(dialogContext);
        bool isUploaded = event;

        if (isUploaded) {
          _showResultDialog('Product Updated Successfully');
        } else {
          _showResultDialog('Failed to update Product');
        }
      });
    });
  }

  void _showResultDialog(String title) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: Colors.green),
            ),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: kPrimaryColor,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isUpdate ? Text('Product Details') : Text('Add Product'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_key.currentState.validate()) {
            _key.currentState.save();
            if (isUpdate) {
              _updateProduct();
            } else {
              _uploadProduct();
            }
          }
        },
        child: isUpdate
            ? Icon(Icons.update_outlined)
            : Icon(Icons.upload_outlined),
      ),
      body: SafeArea(
        child: Container(
          color: kPrimaryColor,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Category',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _categoryValue,
                                icon: Icon(Icons.arrow_drop_down),
                                style: TextStyle(color: Colors.deepPurple),
                                onChanged: (String newValue) {
                                  setState(() {
                                    _categoryValue = newValue;
                                  });
                                },
                                items: _categories
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                              border: Border.all(color: Colors.deepPurple)),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            initialValue:
                                isUpdate ? widget.product.productName : '',
                            decoration: InputDecoration(
                                hintText: 'Product Name',
                                icon: Icon(Icons.emoji_objects_outlined,
                                    color: Colors.deepPurple),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                            onSaved: (value) {
                              setState(() {
                                _productName = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Product Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.deepPurple)),
                          child: TextFormField(
                            minLines: 3,
                            maxLines: 20,
                            initialValue:
                                isUpdate ? widget.product.productDes : '',
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                hintText: 'Product Description',
                                icon: Icon(Icons.description,
                                    color: Colors.deepPurple),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                            onSaved: (value) {
                              setState(() {
                                _productDescription = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Product Description';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                              border: Border.all(color: Colors.deepPurple)),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: isUpdate ? widget.product.price : '',
                            decoration: InputDecoration(
                                hintText: 'Actual Price',
                                icon:
                                    Icon(Icons.money, color: Colors.deepPurple),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                            onSaved: (value) {
                              setState(() {
                                _actualPrice = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Actual Price';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                              border: Border.all(color: Colors.deepPurple)),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue:
                                isUpdate ? widget.product.sellPrice : '',
                            decoration: InputDecoration(
                                hintText: 'Sell Price',
                                icon:
                                    Icon(Icons.money, color: Colors.deepPurple),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                            onSaved: (value) {
                              setState(() {
                                _sellPrice = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Sell Price';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        isUpdate
                            ? GestureDetector(
                                onTap: () {
                                  print('uploaded image no.');
                                  getImage();
                                },
                                child: isImageSelected
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: 16.0, bottom: 60.0),
                                        height: 200.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        ))
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: 16.0, bottom: 60.0),
                                        height: 200.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Image.network(
                                          widget.product.imgUrl,
                                          fit: BoxFit.fill,
                                        )))
                            : GestureDetector(
                                onTap: () {
                                  print('uploaded image no.');
                                  getImage();
                                },
                                child: isImageSelected
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: 16.0, bottom: 60.0),
                                        height: 200.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        ))
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: 16.0, bottom: 60.0),
                                        height: 200.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload_outlined,
                                              size: 90,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                                'Tap To Upload Image of the Product')
                                          ],
                                        ),
                                      ),
                              ),
                      ],
                    ),
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
