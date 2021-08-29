class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGES = "images";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";
  static const SIZE = "size";
  static const COLOR = "color";

  String? _id;
  String? _name;
  List<dynamic>? _images;
  String? _productId;
  String? _size;
  String? _color;
  int? _price;

  //  getters
  String? get id => _id;

  String? get name => _name;

  List<dynamic>? get image => _images;

  String? get productId => _productId;

  String? get size => _size;

  String? get color => _color;

  int? get price => _price;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _images = data[IMAGES];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _size = data[SIZE];
    _color = data[COLOR];
  }

  Map toMap() => {
        ID: _id,
        IMAGES: _images,
        NAME: _name,
        PRODUCT_ID: _productId,
        PRICE: _price,
        SIZE: _size,
        COLOR: _color
      };
}
