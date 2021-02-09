import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickd_business/bloc/registration_bloc.dart';
import 'package:quickd_business/model/category_model.dart';
import 'package:quickd_business/model/user_details.dart';
import 'package:quickd_business/utils/Constants.dart';
import 'package:quickd_business/views/animation/routes.dart';
import 'package:quickd_business/views/components/text_field_container.dart';
import 'package:quickd_business/views/ui/authentication/welcome_ui.dart';

List<String> businessCategories = List();

class RegistrationScreen extends StatefulWidget {
  final String email, phone;
  RegistrationScreen({Key key, @required this.email, @required this.phone})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  List<CategoryModel> _categoryList = [
    CategoryModel(
        icon: Icon(Icons.restaurant), name: 'Restaurant', isCheck: false),
    CategoryModel(
        icon: Icon(Icons.restaurant_menu), name: 'Grocery', isCheck: false),
    CategoryModel(
        icon: Icon(Icons.waterfall_chart), name: 'Water', isCheck: false),
    CategoryModel(
        icon: Icon(Icons.food_bank_sharp), name: 'Meat & Fish', isCheck: false),
    CategoryModel(
        icon: Icon(Icons.local_drink), name: 'Dairy Products', isCheck: false),
    CategoryModel(
        icon: Icon(Icons.food_bank), name: 'Vegetables', isCheck: false),
  ];

  var bloc = RegistrationBloc();
  bool showLoading = false;
  bool isImageSelected = false;
  String name, shopName, shopAddress, docsUrl;
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Add Account Details',
          style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.headline5,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_key.currentState.validate()) {
            _key.currentState.save();
            if (businessCategories.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Select At least One Business Category",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2);
            } else if (_image == null) {
              Fluttertoast.showToast(
                  msg: "Please Upload a image of Govt Issued Id Card",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2);
            } else {
              _registerUser();
            }
          }
        },
        child: Icon(Icons.navigate_next),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
              color: kPrimaryColor,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _key,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 24, 16, 24),
                                child: Container(
                                    height: 160.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: SvgPicture.asset(
                                        'assets/images/profile_details.svg')),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: TextFieldContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        hintText: 'Full Name',
                                        icon: Icon(Icons.person_outline,
                                            color: Colors.deepPurple),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none)),
                                    onSaved: (value) {
                                      setState(() {
                                        if (value.isNotEmpty) {
                                          name = value;
                                        }
                                      });
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Full Name';
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
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText: 'Shop Name',
                                        icon: Icon(Icons.home_outlined,
                                            color: Colors.deepPurple),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none)),
                                    onSaved: (value) {
                                      setState(() {
                                        if (value.isNotEmpty) {
                                          shopName = value;
                                        }
                                      });
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Shop Name';
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
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText: 'Shop Address',
                                        icon: Icon(
                                            Icons.add_location_alt_outlined,
                                            color: Colors.deepPurple),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none)),
                                    onSaved: (value) {
                                      setState(() {
                                        if (value.isNotEmpty) {
                                          shopAddress = value;
                                        }
                                      });
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Shop Name';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(24, 16, 24, 4),
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  child: RaisedButton(
                                    elevation: 0.0,
                                    onPressed: () {
                                      getImage();
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: kPrimaryColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.cloud_upload_outlined,
                                            color: kPrimaryColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Upload Image of Address Proof'),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    'Info: Image of any Govt. issues id card or resturants address proof',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  )),
                              isImageSelected
                                  ? Container(
                                      margin: EdgeInsets.all(16),
                                      height: 200,
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                                child: Text(
                                  'Select Business Categories',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 16, 60),
                                height: 300.0,
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: _categoryList
                                      .map((CategoryModel categoryModel) {
                                    return CategoryListItemView(
                                      categoryModel: categoryModel,
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }

  void _registerUser() {
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
    UserDetails _userDetails = UserDetails(
        email: widget.email,
        phone: widget.phone,
        name: name,
        shopName: shopName,
        shopAddress: shopAddress,
        idUrl: "",
        businessTypes: businessCategories,
        isVerified: false);

    bloc.completeRegistration(_userDetails, _image);
    setState(() {
      showLoading = true;
      bloc.userStream.listen((event) {
        bool isRegistered = event;
        setState(() {
          Navigator.pop(dialogContext);
          _showResultDialog(isRegistered);
        });
      });
    });
  }

  void _showResultDialog(bool istrue)async {
    var box = Hive.box('docs');
    if(istrue){
      box.delete('phone');
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Account Created Successfully"),
            content: istrue
                ? Text(
                    'Account Under Review. Once Your account is activated You can upload and sell products')
                : Text(
                    'Failed to update some info. You will have to update them later'),
            actions: [
              RaisedButton(
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRoutes.fadeThrough(WelcomeScreen()),
                        (route) => false);
                  });
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
}

class CategoryListItemView extends StatefulWidget {
  final CategoryModel categoryModel;
  CategoryListItemView({Key key, this.categoryModel}) : super(key: key);

  @override
  _CategoryListItemViewState createState() => _CategoryListItemViewState();
}

class _CategoryListItemViewState extends State<CategoryListItemView> {
  bool isSelected;

  @override
  void initState() {
    isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Row(
      children: <Widget>[
        Expanded(child: new Text(widget.categoryModel.name)),
        new Checkbox(
            value: widget.categoryModel.isCheck,
            onChanged: (bool value) {
              setState(() {
                widget.categoryModel.isCheck = value;
                if (!isSelected) {
                  if (!businessCategories.contains(widget.categoryModel.name)) {
                    businessCategories.add(widget.categoryModel.name);
                  }
                  print('no. of categories: ${businessCategories.length}');
                  isSelected = true;
                } else {
                  if (businessCategories.contains(widget.categoryModel.name)) {
                    businessCategories.remove(widget.categoryModel.name);
                  }
                  isSelected = false;
                  print('no. of categories: ${businessCategories.length}');
                }
              });
            })
      ],
    ));
  }
}
