import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'package:sqflite_migration/sqflite_migration.dart';

var initialScript = [
  "CREATE TABLE app_users         "
      "  (                                                                          "
      "  user_id   INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,                         "
      "  full_name TEXT NOT NULL,                                                    "
      "  username  TEXT NOT NULL UNIQUE,                                             "
      "  password  TEXT NOT NULL,                                                    "
      "  email     TEXT,                                                             "
      "  phone     TEXT                                                              "
      "  );                                                                         ",
  "  CREATE TABLE app_client                                                     "
      "  (                                                                          "
      "  client_id         INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,        "
      "  name              TEXT                                     NOT NULL UNIQUE, "
      "  phone             TEXT                                     NOT NULL,        "
      "  email             TEXT                                     NOT NULL,        "
      "  contact1          TEXT,                                                     "
      "  contact2          TEXT                                     NOT NULL,        "
      "  phone1            TEXT,                                                     "
      "  phone2            TEXT                                     NOT NULL,        "
      "  billing_address1  TEXT                                     NOT NULL,        "
      "  billing_address2  TEXT,                                                     "
      "  shipping_address1 TEXT,                                                     "
      "  shipping_address2 TEXT,                                                     "
      "  created_by        INTEGER,                                                  "
      "  updated_by        INTEGER,                                                  "
      "  created_at        TEXT,                                                  "
      "  updated_at        TEXT                                                   "
      "  );                                                                         ",
  "  CREATE TABLE app_item                                                       "
      "  (                                                                          "
      "  item_id       INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,            "
      "  name          TEXT                                     NOT NULL UNIQUE,     "
      "  price         INTEGER                                  NOT NULL,            "
      "  quantity      INTEGER                                  NOT NULL,            "
      "  discount      INTEGER,                                                      "
      "  discount_unit INTEGER,                                                      "
      "  tax_rate      INTEGER,                                                      "
      "  description   TEXT,                                                      "
      "  created_by    INTEGER,                                                      "
      "  updated_by    INTEGER,                                                      "
      "  created_at    TEXT,                                                      "
      "  updated_at    TEXT                                                       "
      "  );                                                                         ",
  "  CREATE TABLE app_invoice                                                    "
      "  (                                                                          "
      "  invoice_id    INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,            "
      "  invoice_no    TEXT UNIQUE                              NOT NULL,            "
      "  date          TEXT                                     NOT NULL,            "
      "  due_date      TEXT                                     NOT NULL,            "
      "  client        INTEGER                                  NOT NULL,            "
      "  discount      INTEGER,                                                      "
      "  discount_unit INTEGER,                                                         "
      "  total         INTEGER,                                                      "
      "  tax           INTEGER,                                                      "
      "  paid          INTEGER,                                                      "
      "  created_by    INTEGER,                                                      "
      "  updated_by    INTEGER,                                                      "
      "  created_at    TEXT,                                                      "
      "  updated_at    TEXT                                                       "
      "  );                                                                         ",
  "  CREATE TABLE app_invoice_item                                               "
      "  (                                                                          "
      "  invoice_item_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,          "
      "  invoice         INTEGER                                  NOT NULL,          "
      "  item            INTEGER                                  NOT NULL,          "
      "  quantity        INTEGER                                  NOT NULL,          "
      "  discount        INTEGER,                                                    "
      "  discount_unit   INTEGER,                                                       "
      "  tax             INTEGER,                                                    "
      "  created_by      INTEGER,                                                    "
      "  updated_by      INTEGER,                                                    "
      "  created_at      TEXT,                                                    "
      "  updated_at      TEXT                                                     "
      "  );                                                                         "
];

const migrationScript = [
  "Select * from app_users;",
  "  CREATE TABLE app_client                                                     " +
      "  (                                                                          " +
      "  client_id         INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,        " +
      "  name              TEXT                                     NOT NULL UNIQUE, " +
      "  phone             TEXT                                     NOT NULL,        " +
      "  email             TEXT                                     NOT NULL,        " +
      "  contact1          TEXT,                                                     " +
      "  contact2          TEXT                                     NOT NULL,        " +
      "  phone1            TEXT,                                                     " +
      "  phone2            TEXT                                     NOT NULL,        " +
      "  billing_address1  TEXT                                     NOT NULL,        " +
      "  billing_address2  TEXT,                                                     " +
      "  shipping_address1 TEXT,                                                     " +
      "  shipping_address2 TEXT,                                                     " +
      "  created_by        INTEGER,                                                  " +
      "  updated_by        INTEGER,                                                  " +
      "  created_at        TEXT,                                                  " +
      "  updated_at        TEXT                                                   " +
      "  );                                                                         ",
  "  CREATE TABLE app_item                                                       " +
      "  (                                                                          " +
      "  item_id       INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,            " +
      "  name          TEXT                                     NOT NULL UNIQUE,     " +
      "  price         INTEGER                                  NOT NULL,            " +
      "  quantity      INTEGER                                  NOT NULL,            " +
      "  discount      INTEGER,                                                      " +
      "  discount_unit INTEGER,                                                      " +
      "  tax_rate      INTEGER,                                                      " +
      "  description   TEXT,                                                      " +
      "  created_by    INTEGER,                                                      " +
      "  updated_by    INTEGER,                                                      " +
      "  created_at    TEXT,                                                      " +
      "  updated_at    TEXT                                                       " +
      "  );                                                                         ",
  "  CREATE TABLE app_invoice                                                    " +
      "  (                                                                          " +
      "  invoice_id    INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,            " +
      "  invoice_no    TEXT UNIQUE                              NOT NULL,            " +
      "  date          TEXT                                     NOT NULL,            " +
      "  due_date      TEXT                                     NOT NULL,            " +
      "  client        INTEGER                                  NOT NULL,            " +
      "  discount      INTEGER,                                                      " +
      "  discount_unit TEXT,                                                         " +
      "  total         INTEGER,                                                      " +
      "  tax           INTEGER,                                                      " +
      "  paid          INTEGER,                                                      " +
      "  created_by    INTEGER,                                                      " +
      "  updated_by    INTEGER,                                                      " +
      "  created_at    TEXT,                                                      " +
      "  updated_at    TEXT                                                       " +
      "  );                                                                         ",
  "  CREATE TABLE app_invoice_item                                               " +
      "  (                                                                          " +
      "  invoice_item_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,          " +
      "  invoice         INTEGER                                  NOT NULL,          " +
      "  item            INTEGER                                  NOT NULL,          " +
      "  quantity        INTEGER                                  NOT NULL,          " +
      "  discount        INTEGER,                                                    " +
      "  discount_type   TEXT,                                                       " +
      "  tax             INTEGER,                                                    " +
      "  created_by      INTEGER,                                                    " +
      "  updated_by      INTEGER,                                                    " +
      "  created_at      TEXT,                                                    " +
      "  updated_at      TEXT                                                     " +
      "  );  ",
];

class DBHelper {
  static Database? _db;

  static const DB_NAME = 'billing_app.db';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();

    return _db;
  }

  initDB() async {
    final config = MigrationConfig(
        initializationScript: initialScript, migrationScripts: migrationScript);
    io.Directory dbDirectory = await getApplicationDocumentsDirectory();
    String path = join(dbDirectory.path, DB_NAME);
    var db = await openDatabaseWithMigration(path, config);
    return db;
  }
}
