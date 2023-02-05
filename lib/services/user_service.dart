import 'package:billing_app/model/addrress.dart';
import 'package:billing_app/model/userDTO.dart';
import 'package:billing_app/services/BaseService.dart';

class UserService extends BaseService {
  UserService() : super() {
    tableName = "app_users";
  }

  createUser(User user) async {
    var db = await this.db;
    return await db?.insert(tableName, user.toMap());
  }
}
