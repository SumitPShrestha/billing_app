import 'package:billing_app/dto/item_dto.dart';
import 'package:billing_app/model/item.dart';
import 'package:billing_app/services/BaseService.dart';
import 'package:collection/collection.dart';

class ItemService extends BaseService {
  ItemService() : super() {
    tableName = "app_item";
  }

  Future<List<ItemDTO>> getAllItems(String? where, int? limit) async {
    var db = await this.db;
    return (await db?.query(tableName, limit: limit))!
        .map((e) => Item.fromMap(e))
        .toList()
        .map((e) => ItemDTO(e))
        .toList();
  }

  Future<int?> create(Item item) async {
    var db = await this.db;
    return db?.insert(tableName, item.toMap());
  }

  getGrossPrice(Item item) {
    double? discountPrice = 0;
    double? taxAmount = 0;
    if (item.discount != null) {
      if (item.discount_unit == "1") {
        discountPrice =
            item.discount ?? ((item!.price! / 100) * item!.discount!);
      } else {
        discountPrice = item.discount;
      }
    } else {
      discountPrice = 0;
    }
    if (item.tax_rate != null) {
      taxAmount = item.tax_rate ?? ((item!.price! / 100) * item!.tax_rate!);
    } else {
      taxAmount = 0;
    }
    return item.price! - discountPrice! + taxAmount;
  }

  Future<Iterable<Item>> getClientsWhere(
      List<String> where, List<String> args, int index) async {
    var db = await this.db;
    String whereCond = '';
    where.forEachIndexed((i, w) {
      if (i == where.length - 1) {
        whereCond = whereCond + " $w LIKE ?";
      } else {
        whereCond = whereCond + " $w LIKE ?' AND ";
      }
    });
    return (await db!.query(tableName, where: whereCond, whereArgs: args))
        .map((e) => Item.fromMap(e));
  }
}
