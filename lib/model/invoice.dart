import 'package:billing_app/model/base_model.dart';

class Invoice extends BaseModel {
  late int? _invoice_id;
  late String? _invoice_no;
  late String? _date;
  late String? _due_date;
  late int? _client;
  late double? _discount;
  late int? _discount_type;
  late double? _total;
  late double? _tax;
  late int? _paid;

  Invoice(
    this._invoice_id,
    this._invoice_no,
    this._date,
    this._due_date,
    this._client,
    this._discount,
    this._discount_type,
    this._total,
    this._tax,
    this._paid,
  );

  Invoice.fromMap(dynamic obj) {
    _invoice_id = obj['invoice_id'];
    _invoice_no = obj['invoice_no'];
    _date = obj['date'];
    _due_date = obj['due_date'];
    _client = obj['client'];
    _discount = obj['discount'];
    _discount_type = obj['discount_type'];
    _total = obj['total'];
    _tax = obj['tax'];
    _paid = obj['paid'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["_invoice_id"] = _invoice_id;
    map["_invoice_no"] = _invoice_no;
    map["_date"] = _date;
    map["_due_date"] = _due_date;
    map["_client"] = _client;
    map["_discount"] = _discount;
    map["_discount_type"] = _discount_type;
    map["_total"] = _total;
    map["_tax"] = _tax;
    map["_paid"] = _paid;
    return map;
  }

  int? get paid => _paid;

  set paid(int? value) {
    _paid = value;
  }

  double? get tax => _tax;

  set tax(double? value) {
    _tax = value;
  }

  double? get total => _total;

  set total(double? value) {
    _total = value;
  }

  int? get discount_type => _discount_type;

  set discount_type(int? value) {
    _discount_type = value;
  }

  double? get discount => _discount;

  set discount(double? value) {
    _discount = value;
  }

  int? get client => _client;

  set client(int? value) {
    _client = value;
  }

  String? get due_date => _due_date;

  set due_date(String? value) {
    _due_date = value;
  }

  String? get date => _date;

  set date(String? value) {
    _date = value;
  }

  String? get invoice_no => _invoice_no;

  set invoice_no(String? value) {
    _invoice_no = value;
  }

  int? get invoice_id => _invoice_id;

  set invoice_id(int? value) {
    _invoice_id = value;
  }
}
