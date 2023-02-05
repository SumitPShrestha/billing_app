import 'package:billing_app/model/base_model.dart';

class Address extends BaseModel {
  late int? _id;
  late int? _userId;
  late String? _street1;
  late String? _street2;
  late String? _mp_vdc;
  late String? _district;

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  late String? _zone;
  late String? _state;

  Address(
    this._id,
    this._userId,
    this._street1,
    this._street2,
    this._mp_vdc,
    this._district,
    this._zone,
    this._state,
  );

  Address.fromMap(dynamic obj) {
    print(obj.toString());

    _id = obj['addressId'];
    _userId = obj['userId'];
    _street1 = obj['street1'];
    _street2 = obj['street2'];
    _mp_vdc = obj['mp_vdc'];
    _district = obj['district'];
    _zone = obj['zone'];
    _state = obj['state'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["userId"] = _userId;
    map["street1"] = _street1;
    map["street2"] = _street2;
    map["mp_vdc"] = _mp_vdc;
    map["district"] = _district;
    map["zone"] = _zone;
    map["state"] = _state;
    return map;
  }

  int? get userId => _userId;

  set userId(int? value) {
    _userId = value;
  }

  String? get street1 => _street1;

  set street1(String? value) {
    _street1 = value;
  }

  String? get street2 => _street2;

  set street2(String? value) {
    _street2 = value;
  }

  String? get mpVdc => _mp_vdc;

  set mpVdc(String? value) {
    _mp_vdc = value;
  }

  String? get district => _district;

  set district(String? value) {
    _district = value;
  }

  String? get zone => _zone;

  set zone(String? value) {
    _zone = value;
  }

  String? get state => _state;

  set state(String? value) {
    _state = value;
  }
}
