//import 'dart:async';
//import 'dart:io' as io;
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:hotel_manager/model.dart';
//
//class DBHelper{
//
//  static Database _db;
//
//  Future<Database> get db async {
//    if(_db != null)
//      return _db;
//    _db = await initDb();
//    return _db;
//  }
//
//  //Creating a database with name test.dn in your directory
//  initDb() async {
//    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, "hotel.db");
//    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
//    return theDb;
//  }
//
//  // Creating a table name Customer with fields
//  void _onCreate(Database db, int version) async {
//    // When creating the db, create the table
//    await db.execute(
//        "CREATE TABLE Customer(id INTEGER PRIMARY KEY, name TEXT, phone TEXT, paid TEXT,datestart TEXT, dateend TEXT )");
//    print("Created tables");
//  }
//
//  // Retrieving Customers from Customer Tables
//  Future<List<Customer>> getCustomers() async {
//    var dbClient = await db;
//    List<Map> list = await dbClient.rawQuery('SELECT * FROM Customer');
//    List<Customer> Customers = new List();
//    for (int i = 0; i < list.length; i++) {
//      Customers.add(new Customer(list[i]["name"], list[i]["phone"], list[i]["paid"], list[i]["datestart"], list[i]["dateend"]));
//    }
//    print(Customers.length);
//    return Customers;
//  }
//  Future<List<Customer>>deleteCustomer() async{
//
//  }
//
//  void saveCustomer(Customer Customer) async {
//    var dbClient = await db;
//    await dbClient.transaction((txn) async {
//      return await txn.rawInsert(
//          'INSERT INTO Customer(name, phone, paid, datestart, dateend ) VALUES(' +
//              '\'' +
//              Customer.name +
//              '\'' +
//              ',' +
//              '\'' +
//              Customer.phone +
//              '\'' +
//              ',' +
//              '\'' +
//              Customer.paid +
//              '\'' +
//              ',' +
//              '\'' +
//              Customer.datestart +
//              '\'' +
//              ','+'\'' +
//              Customer.dateend +
//              '\'' +
//              ')' );
//    });
//  }
//
//
//
//
//}