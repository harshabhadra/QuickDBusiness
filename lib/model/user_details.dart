class UserDetails {
  String _email;
  String _phone;
  String _name;
  String _shopName;
  String _shopAddress;
  String _idUrl;
  List<String> _businessTypes;
  bool _isVerified;

  UserDetails(
      {String email,
      String phone,
      String name,
      String shopName,
      String shopAddress,
      String idUrl,
      List<String> businessTypes,
      bool isVerified}) {
    this._email = email;
    this._phone = phone;
    this._name = name;
    this._shopName = shopName;
    this._shopAddress = shopAddress;
    this._idUrl = idUrl;
    this._businessTypes = businessTypes;
    this._isVerified = isVerified;
  }

  String get email => _email;
  String get phone => _phone;
  String get name => _name;
  set name(String name) => _name = name;
  String get shopName => _shopName;
  set shopName(String shopName) => _shopName = shopName;
  String get shopAddress => _shopAddress;
  set shopAddress(String shopAddress) => _shopAddress = shopAddress;
  String get idUrl => _idUrl;
  set setIdUrl(String idUrl) => _idUrl = idUrl;
  List<String> get businessTypes => _businessTypes;
  set businessTypes(List<String> businessTypes) =>
      _businessTypes = businessTypes;
  bool get isVerified => _isVerified;

  UserDetails.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _shopName = json['shopName'];
    _shopAddress = json['shopAddress'];
    _businessTypes = json['businessTypes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['shopName'] = this._shopName;
    data['shopAddress'] = this._shopAddress;
    data['businessTypes'] = this._businessTypes;
    return data;
  }
}
