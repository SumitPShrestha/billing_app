import 'package:billing_app/model/addrress.dart';
import 'package:billing_app/model/client.dart';

class ClientDTO {
  Client? client;
  Address? address;

  ClientDTO({this.client, this.address});
}
