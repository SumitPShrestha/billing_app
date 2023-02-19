import 'package:billing_app/dto/Invoice_dto.dart';
import 'package:billing_app/model/invoice.dart';
import 'package:billing_app/model/invoice_item.dart';
import 'package:billing_app/model/item.dart';
import 'package:billing_app/services/BaseService.dart';
import 'package:sqflite/sqflite.dart';

class InvoiceService extends BaseService {
  InvoiceService() : super() {
    tableName = "app_invoice";
  }

  Future<List<InvoiceDTO>> getAllItems(String? where, int? limit) async {
    Database? db = await this.db;
    Invoice? i;
    List<InvoiceItem>? invoiceItems;
    return (await db?.query(tableName, limit: limit).then((value) {
      i = Invoice.fromMap(value);

      return db
          .query("app_invoice_item",
              where: 'invoice = ?', whereArgs: [i!.invoice_id], limit: limit)
          .asStream()
          .map((event) {
        InvoiceItem ii = InvoiceItem.fromMap(event);
        invoiceItems!.add(ii);
        return ii;
      });
    }))!
        .map((e) => InvoiceDTO())
        .toList();
  }

  Future<int?> create(Item item) async {
    var db = await this.db;
    return db?.insert(tableName, item.toMap());
  }

  Future<String> generateInvoiceId() async {
    var db = await this.db;
    List<Map<String, Object?>>? lastRow = await db
        ?.rawQuery("SELECT last_insert_rowid() as id from app_invoice")
        .asStream()
        .map((r) => r)
        .first;
    return "INV${(lastRow != null && lastRow.length > 0) ? lastRow[0] : '1'}";
  }

  getGrossPrice(Item item) {
    double? discountPrice = 0;
    double? taxAmount = 0;
    if (item.discount_unit == "1") {
      discountPrice = item.discount ?? ((item.price! / 100) * item.discount!);
    } else {
      discountPrice = item.discount;
    }
    if (item.tax_rate != null) {
      taxAmount = item.tax_rate ?? ((item.price! / 100) * item.tax_rate!);
    }
    return item.price! - discountPrice! + taxAmount;
  }

  getInvoiceById(int ID) async {
    Database? db = await this.db;
    return await db!
        .rawQuery(
            "SELECT * FROM app_invoice AI LEFT JOIN app_invoice_item AII ON AI.invoice_id = AII.invoice WHERE AI.invoice_id = $ID")
        .asStream()
        .map((res) {
      return null;
      // InvoiceItemDTO itemDTO = InvoiceItemDTO(res., item_name, quantity, is_available_in_inventory, price)
    });
  }
}
