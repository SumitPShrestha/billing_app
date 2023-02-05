import 'package:billing_app/model/addrress.dart';
import 'package:billing_app/services/BaseService.dart';

class AddressService extends BaseService {
  AddressService() : super() {
    this.tableName = "app_address";
  }

  Future<Address> findOneByID(int id) async {
    var db = await this.db;
    var add = await db?.query(tableName, where: 'id', whereArgs: [id]);
    return add!.map((e) => Address.fromMap(e)).toList()[0];
  }
}
