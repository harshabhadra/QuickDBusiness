import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickd_business/model/product_model.dart';
import 'package:quickd_business/model/user_details.dart';
import 'package:quickd_business/views/animation/routes.dart';
import 'package:quickd_business/views/ui/main/add_product_ui.dart';

class MyProductsScreen extends StatefulWidget {
  final UserDetails userDetails;
  MyProductsScreen({Key key, @required this.userDetails}) : super(key: key);

  @override
  _MyProductsScreenState createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  List<Product> _productList = List();

  @override
  void dispose() {
    _productList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
      ),
      body: _buildMyProductPage(),
    );
  }

  Widget _buildMyProductPage() {
    CollectionReference products =
        FirebaseFirestore.instance.collection('Products');

    return StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              List<DocumentSnapshot> _list = snapshot.data.docs;

              for (DocumentSnapshot document in _list) {
                if (document.data()['shop'] == widget.userDetails.shopName) {
                  _productList.add(Product(
                      docId: document.id,
                      category: document.data()['category'],
                      productName: document.data()['productName'],
                      productDes: document.data()['productDes'],
                      price: document.data()['price'],
                      sellPrice: document.data()['sellPrice'],
                      imgUrl: document.data()['imgUrl'],
                      restaurant: document.data()['shop'],
                      rating: document.data()['rating'],
                      isAvailable: document.data()['isAvailable']));
                }
              }
              return _productList.isNotEmpty
                  ? _buildProductList(_productList)
                  : Center(
                      child: Text(
                        "No Products Found",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
            }
          }
        });
  }

  Widget _buildProductList(List<Product> productList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            Product _product = productList[index];
            return GestureDetector(
              onTap: () {
                _productList.clear();
                Navigator.push(
                    context,
                    PageRoutes.sharedAxis(AddProductScreen(
                        userDetails: widget.userDetails,
                        product: _product,
                        docId: _product.docId)));
              },
              child: Card(
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1, child: Image.network(_product.imgUrl)),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Text(
                                  _product.productName,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Text(
                                  'Price: ₹ ${_product.price}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Text(
                                  'Sell Price: ₹ ${_product.sellPrice}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                  child: _product.isAvailable
                                      ? Text(
                                          'Available',
                                          style: TextStyle(color: Colors.green),
                                        )
                                      : Text(
                                          'Not Available',
                                          style: TextStyle(color: Colors.red),
                                        ))
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.edit_outlined), onPressed: () {})
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
