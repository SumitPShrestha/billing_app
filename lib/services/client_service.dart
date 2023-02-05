import 'package:billing_app/dto/client_dto.dart';
import 'package:billing_app/model/client.dart';
import 'package:billing_app/services/BaseService.dart';
import 'package:collection/collection.dart';
import '../model/addrress.dart';

class ClientService extends BaseService {
  ClientService() : super() {
    tableName = "app_client";
  }

  Future<List<ClientDTO>> getClients(String? where, int? limit) async {
    var db = await this.db;
    var clientRes = await db?.rawQuery("Select * from app_client;");
    return clientRes!.map((r) => ClientDTO(client: Client.fromMap(r))).toList();
  }

  Future<Iterable<Client>> getClientsWhere(List<String> where, List<String> args,
      int? limit) async {
    var db = await this.db;
    String whereCond = '';
    where.forEachIndexed((i, w) {
      if (i == where.length - 1) {
        whereCond = whereCond + " $w LIKE ?";
      } else {
        whereCond = whereCond + " $w LIKE ?' AND ";
      }
    });

    return (await db
    !.query(tableName, where: whereCond, whereArgs: args)).map((e) =>
        Client.fromMap(e));
  }

  Future<int?> createClient(Client client) async {
    var db = await this.db;
    if (client.client_id == null) {
      return db!.insert(tableName, client.toMap());
    } else {
      return db!.update(tableName, client.toMap(),
          where: 'client_id = ?', whereArgs: [client!.client_id]);
    }
  }

  delete(Client? client) async {
    var db = await this.db;

    int? id = await db!
        .delete(tableName, where: 'id = ?', whereArgs: [client?.client_id]);
    return id;
  }
}
