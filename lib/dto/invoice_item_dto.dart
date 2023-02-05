class InvoiceItemDTO{
  int? item_id;
  int? invoice_id;
  String? item_name;
  int? quantity;
  bool? is_available_in_inventory ;
  double? price;

  InvoiceItemDTO(this.item_id, this.item_name, this.quantity,
      this.is_available_in_inventory, this.price);
}
