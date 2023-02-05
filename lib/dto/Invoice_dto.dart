import 'package:billing_app/dto/invoice_item_dto.dart';
import 'package:billing_app/model/invoice.dart';
import 'package:billing_app/model/invoice_item.dart';

class InvoiceDTO {
  late int? invoiceId;
  late String? clientName;
  late int? clientID;
  late String? date;
  late double? discount;
  late int? discount_unit;
  late int? tax_rate;
  late int? total_price;
  late List<InvoiceItemDTO>? invoiceItems;


}
