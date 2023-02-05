import 'package:billing_app/model/base_model.dart';

class Client extends BaseModel {
  late int? _client_id;
  late String? _name;
  late String? _phone;
  late String? _email;
  late String? _contact1;
  late String? _contact2;
  late String? _phone1;
  late String? _phone2;
  late String? _billing_address1;
  late String? _billing_address2;
  late String? _shipping_address1;
  late String? _shipping_address2;

  Client(
      this._client_id,
      this._name,
      this._phone,
      this._email,
      this._contact1,
      this._contact2,
      this._phone1,
      this._phone2,
      this._billing_address1,
      this._billing_address2,
      this._shipping_address1,
      this._shipping_address2);

  Client. fromMap(dynamic obj) {
    _client_id = int.parse(obj["client_id"].toString());
    _name = obj["name"];
    _phone = obj["phone"];
    _email = obj["email"];
    _contact1 = obj["contact1"];
    _contact2 = obj["contact2"];
    _phone1 = obj["phone1"];
    _phone2 = obj["phone2"];
    _billing_address1 = obj["billing_address1"];
    _billing_address2 = obj["billing_address2"];
    _shipping_address1 = obj["shipping_address1"];
    _shipping_address2 = obj["shipping_address2"];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["client_id"] = _client_id;
    map["name"] = _name;
    map["phone"] = _phone;
    map["email"] = _email;
    map["contact1"] = _contact1;
    map["contact2"] = _contact2;
    map["phone1"] = _phone1;
    map["phone2"] = _phone2;
    map["billing_address1"] = _billing_address1;
    map["billing_address2"] = _billing_address2;
    map["shipping_address1"] = _shipping_address1;
    map["shipping_address2"] = _shipping_address2;
    return map;
  }

  String? get shipping_address2 => _shipping_address2;

  set shipping_address2(String? value) {
    _shipping_address2 = value;
  }

  String? get shipping_address1 => _shipping_address1;

  set shipping_address1(String? value) {
    _shipping_address1 = value;
  }

  String? get billing_address2 => _billing_address2;

  set billing_address2(String? value) {
    _billing_address2 = value;
  }

  String? get billing_address1 => _billing_address1;

  set billing_address1(String? value) {
    _billing_address1 = value;
  }

  String? get phone2 => _phone2;

  set phone2(String? value) {
    _phone2 = value;
  }

  String? get phone1 => _phone1;

  set phone1(String? value) {
    _phone1 = value;
  }

  String? get contact2 => _contact2;

  set contact2(String? value) {
    _contact2 = value;
  }

  String? get contact1 => _contact1;

  set contact1(String? value) {
    _contact1 = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  int? get client_id => _client_id;

  set client_id(int? value) {
    _client_id = value;
  }
}
