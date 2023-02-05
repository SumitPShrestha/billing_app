import 'package:billing_app/model/base_model.dart';
import 'package:sqflite/sqflite.dart';

import '../DBHelper.dart';

abstract class BaseService {
  late Future<Database?> db;

  BaseService() {
    db = DBHelper()!.db;
  }

  late String _tableName;

  String get tableName => _tableName;

  set tableName(String value) {
    _tableName = value;
  }

  Future<int?> insert(BaseModel model) async {
    var db = await this.db;
    if (db != null) {
      final id = await db!.insert(tableName, model.toMap());
      return id;
    } else {
      return null;
    }
  }

  Future getAllData({String? where, int? limit}) async {
    var db = await this.db;
    return await db?.query(tableName, limit: limit);
  }
}
