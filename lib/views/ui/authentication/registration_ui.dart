import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickd_business/model/category_model.dart';
import 'package:quickd_business/utils/Constants.dart';
import 'package:quickd_business/views/components/text_field_container.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        onPressed: () {},
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
                                      setState(() {});
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
                                      setState(() {});
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
                                      setState(() {});
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
                                    onPressed: () {},
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
}

class CategoryListItemView extends StatefulWidget {
  final CategoryModel categoryModel;
  CategoryListItemView({Key key, this.categoryModel}) : super(key: key);

  @override
  _CategoryListItemViewState createState() => _CategoryListItemViewState();
}

class _CategoryListItemViewState extends State<CategoryListItemView> {
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
              });
            })
      ],
    ));
  }
}
