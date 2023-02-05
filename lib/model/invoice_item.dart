import 'package:billing_app/model/base_model.dart';

class InvoiceItem extends BaseModel {
  late int? _invoice_item_id;
  late int? _invoice;
  late int? _item;
  late int? _quantity;
  late double? _discount;
  late int? _discount_type;
  late double? _tax;

  InvoiceItem(
    this._invoice_item_id,
    this._invoice,
    this._item,
    this._quantity,
    this._discount,
    this._discount_type,
    this._tax,
  );

  InvoiceItem.fromMap(dynamic obj) {
    _invoice_item_id = obj['invoice_item_id'];
    _invoice = obj['invoice'];
    _item = obj['item'];
    _quantity = obj['quantity'];
    _discount = obj['discount'];
    _discount_type = obj['discount_type'];
    _tax = obj['tax'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["invoice_item_id"] = _invoice_item_id;
    map["invoice"] = _invoice;
    map["item"] = _item;
    map["quantity"] = _quantity;
    map["discount"] = _discount;
    map["discount_type"] = _discount_type;
    map["tax"] = _tax;
    return map;
  }

  double? get tax => _tax;

  set tax(double? value) {
    _tax = value;
  }

  int? get discount_type => _discount_type;

  set discount_type(int? value) {
    _discount_type = value;
  }

  double? get discount => _discount;

  set discount(double? value) {
    _discount = value;
  }

  int? get quantity => _quantity;

  set quantity(int? value) {
    _quantity = value;
  }

  int? get item => _item;

  set item(int? value) {
    _item = value;
  }

  int? get invoice => _invoice;

  set invoice(int? value) {
    _invoice = value;
  }

  int? get invoice_item_id => _invoice_item_id;

  set invoice_item_id(int? value) {
    _invoice_item_id = value;
  }
}
