import 'package:billing_app/model/base_model.dart';

class Item extends BaseModel {
  int? _item_id;
  String? _name;
  double? _price;
  int? _quantity;
  double? _discount;
  int? _discount_unit;
  double? _tax_rate;
  String? _description;

  Item(this._item_id, this._name, this._price, this._quantity, this._discount,
      this._discount_unit, this._tax_rate, this._description);

  Item.fromMap(dynamic obj) {
    _item_id = obj["item_id"];
    _name = obj["name"];
    _price = double.parse(obj["price"].toString());
    _quantity =int.parse( obj["quantity"].toString());
    _discount =double.parse( (obj["discount"]??0.00).toString());
    _discount_unit =int.parse( (obj["discount_unit"]??0).toString());
    _tax_rate =double.parse( (obj["tax_rate"]??0.00).toString());
    _description = obj["description"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["item_id"] = _item_id;
    map["name"] = _name;
    map["price"] = _price;
    map["quantity"] = _quantity;
    map["discount"] = _discount;
    map["discount_unit"] = _discount_unit;
    map["tax_rate"] = _tax_rate;
    map["description"] = _description;

    return map;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  double? get tax_rate => _tax_rate;

  set tax_rate(double? value) {
    _tax_rate = value;
  }

  int? get discount_unit => _discount_unit;

  set discount_unit(int? value) {
    _discount_unit = value;
  }

  double? get discount => _discount;

  set discount(double? value) {
    _discount = value;
  }

  int? get quantity => _quantity;

  set quantity(int? value) {
    _quantity = value;
  }

  double? get price => _price;

  set price(double? value) {
    _price = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  int? get item_id => _item_id;

  set item_id(int? value) {
    _item_id = value;
  }
}
