class Credentials {
  late String _username;
  late String _password;

  Credentials(
    this._username,
    this._password,
  );

  Credentials.fromMap(dynamic obj) {
    _username = obj['username'];
    _password = obj['password'];
  }

  String get username => _username;

  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["username"] = _username;
    map["password"] = _password;
    return map;
  }
}
