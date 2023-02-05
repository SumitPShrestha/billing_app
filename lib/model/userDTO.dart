import 'package:billing_app/model/addrress.dart';
import 'package:billing_app/model/base_model.dart';

class User extends BaseModel {
  late int? _user_id;
  late String? _full_name;
  late String? _username;
  late String? _password;
  late String? _email;
  late String? _phone;

  User(
    this._user_id,
    this._full_name,
    this._username,
    this._password,
    this._email,
    this._phone,
  );

  User.fromMap(dynamic obj) {
    _user_id = obj["user_id"];
    _full_name = obj["full_name"];
    _username = obj["username"];
    _password = obj["password"];
    _email = obj["email"];
    _phone = obj["phone"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["user_id"] = _user_id;
    map["full_name"] = _full_name;
    map["username"] = _username;
    map["password"] = _password;
    map["email"] = _email;
    map["phone"] = _phone;
    return map;
  }

  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get password => _password;

  set password(String? value) {
    _password = value;
  }

  String? get username => _username;

  set username(String? value) {
    _username = value;
  }

  String? get full_name => _full_name;

  set full_name(String? value) {
    _full_name = value;
  }

  int? get userId => _user_id;

  set userId(int? value) {
    _user_id = value;
  }
}
