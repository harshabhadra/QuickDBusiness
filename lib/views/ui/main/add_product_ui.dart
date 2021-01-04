import 'package:flutter/material.dart';
import 'package:quickd_business/utils/Constants.dart';
import 'package:quickd_business/views/components/text_field_container.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String _categoryValue = 'Restaurant';
  GlobalKey<FormState> _key = GlobalKey();
  String _productName, _productDescription, _actualPrice, _sellPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.upload_outlined),
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
                                items: <String>[
                                  'Restaurant',
                                  'Two',
                                  'Free',
                                  'Four'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                            keyboardType: TextInputType.name,
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
                            keyboardType: TextInputType.name,
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
                        GestureDetector(
                          onTap: () {
                            print('uploaded image no.');
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 16.0, bottom: 60.0),
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 90,
                                  color: Colors.grey,
                                ),
                                Text('Tap To Upload Image of the Product')
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
