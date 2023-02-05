import 'package:billing_app/services/BaseService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/userDTO.dart';

class AuthService extends BaseService {
  Future<SharedPreferences> _prefs;

  AuthService(this._prefs) : super() {
    tableName = "app_users";
  }

  Future<User?> doLogin(String username, String password) async {
    var db = await this.db;
    var userVal = await db!.query(tableName,
        where: "username = ?", whereArgs: [username], limit: 1);

    if (userVal.isNotEmpty) {
      User resUser = User.fromMap(userVal[0]);
      if (resUser.password == password) {
        final SharedPreferences prefs = await _prefs;
        prefs.setString('credential', resUser.toString());
      }
      return resUser;
    }
    return null;
  }
}
