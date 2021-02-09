class Product {
  String _docId;
  String _category;
  String _productName;
  String _productDes;
  String _price;
  String _sellPrice;
  String _imgUrl;
  String _restaurant;
  String _rating;
  bool _isAvailable;

  Product(
      {String docId,
      String category,
      String productName,
      String productDes,
      String price,
      String sellPrice,
      String imgUrl,
      String restaurant,
      String rating,
      bool isAvailable}) {
    this._docId = docId;
    this._category = category;
    this._productName = productName;
    this._productDes = productDes;
    this._price = price;
    this._sellPrice = sellPrice;
    this._imgUrl = imgUrl;
    this._restaurant = restaurant;
    this._rating = rating;
    this._isAvailable = isAvailable;
  }

  String get docId => _docId;
  set docId(String docId) => _docId = docId;
  String get category => _category;
  set category(String category) => _category = category;
  String get productName => _productName;
  set productName(String productName) => _productName = productName;
  String get productDes => _productDes;
  set productDes(String productDes) => _productDes = productDes;
  String get price => _price;
  set price(String price) => _price = price;
  String get sellPrice => _sellPrice;
  set sellPrice(String sellPrice) => _sellPrice = sellPrice;
  String get imgUrl => _imgUrl;
  set imgUrl(String imgUrl) => _imgUrl = imgUrl;
  String get restaurant => _restaurant;
  set restaurant(String restaurant) => _restaurant = restaurant;
  String get rating => _rating;
  set rating(String rating) => _rating = rating;
  bool get isAvailable => _isAvailable;
  set isAvailable(bool isAvailable) => _isAvailable = isAvailable;

  Product.fromJson(Map<String, dynamic> json) {
    _category = json['category'];
    _productName = json['productName'];
    _productDes = json['productDes'];
    _price = json['price'];
    _sellPrice = json['sellPrice'];
    _imgUrl = json['imgUrl'];
    _restaurant = json['restaurant'];
    _rating = json['rating'];
    _isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this._category;
    data['productName'] = this._productName;
    data['productDes'] = this._productDes;
    data['price'] = this._price;
    data['sellPrice'] = this._sellPrice;
    data['imgUrl'] = this._imgUrl;
    data['restaurant'] = this._restaurant;
    data['rating'] = this._rating;
    data['isAvailable'] = this._isAvailable;
    return data;
  }
}
