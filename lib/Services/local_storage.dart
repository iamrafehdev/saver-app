import 'dart:io';

import 'package:saver/Models/item_model.dart';
import 'package:saver/Utils/custom_snackbar.dart';
import 'package:saver/Utils/save_file.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/catagory_model.dart';

const String dbName = 'depreciate.sqlite';

const String itemsTable = 'Items';
const String catagoriesTable = 'Catagories';

class LocalStorageService {
  late Database _database;

  Future initialise() async {
    Directory appPath = Directory("/storage/emulated/0/Depreciator/Database/");
    if (await appPath.exists()) {
    } else {
      appPath.create(recursive: true);
    }
    _database = await openDatabase(
      appPath.path + dbName,
      version: 1,
      onCreate: (db, version) async {
        /// creating catagories table
        await db.execute(creatCatagoryTable);

        /// creating item table
        await db.execute(creatItemTable);
      },
    );
  }

  void importBackup(String filePath) async {
    Directory appPath = Directory("/storage/emulated/0/Depreciator/Database/$dbName");
    if (await appPath.exists()) {
    } else {
      appPath.create(recursive: true);
    }
    if (filePath.contains(".sqlite")) {
      await saveDbFile(filePath, appPath.path);
      return customSnackBar.showSnackbar(title: "Successfull", message: "Please restart your application for complete restoring.");
    }
    return customSnackBar.showSnackbar(title: "Sorry", message: "Please select a valid sqflite file");
  }

  /// Items Queries
  ///
  Future addItem({required ItemModel item}) async {
    try {
      await _database.insert(
        itemsTable,
        item.toMap(),
      );
      return true;
    } catch (e) {
      return 'Could not insert the Item: $e';
    }
  }

  Future updateItem({required ItemModel item}) async {
    print(item.id);
    try {
      var res = await _database.update(
        itemsTable,
        item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
      print(res);
      return true;
    } catch (e) {
      return 'Could not insert the Item: $e';
    }
  }

  Future deleteItem(ItemModel item) async {
    try {
      await _database.delete(itemsTable, where: 'id=?', whereArgs: [item.id]);
      return true;
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<List<ItemModel>> getAllItems() async {
    // Get all the data from the DailyTableName
    List<Map> transactionResults = await _database.query(
      itemsTable,
    );
    // Map data to a Transaction object
    return transactionResults.map((trans) => ItemModel.fromMap(trans as Map<String, dynamic>)).toList();
  }

  /// Catagories Queries

  Future addCatagory({required CatagoryModel item}) async {
    try {
      await _database.insert(
        catagoriesTable,
        item.toMap(),
      );
      return true;
    } catch (e) {
      return 'Could not insert Catagory: $e';
    }
  }

  Future deleteCatagory(CatagoryModel item) async {
    try {
      // await _database.delete(catagoriesTable, where: 'id=?', whereArgs: [item.id]);
      await _database.delete(catagoriesTable, where: 'name =?', whereArgs: [item.name]);
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<List<CatagoryModel>> getAllCatagories() async {
    // Get all the data from the DailyTableName
    List<Map> transactionResults = await _database.query(
      catagoriesTable,
    );
    // Map data to a Transaction object
    return transactionResults.map((trans) => CatagoryModel.fromMap(trans as Map<String, dynamic>)).toList();
  }
}

String creatCatagoryTable = '''
      create table IF NOT EXISTS $catagoriesTable ( 
         id integer primary key autoincrement, 
         name text not null)''';

String creatItemTable = '''
      create table IF NOT EXISTS $itemsTable ( 
         id integer primary key autoincrement, 
         name text not null,
         catagory text not null,
         datePurchased text not null,
         expiryDate text not null,
         dateAdded text not null,
         notes text not null,
         purchaseAmount float not null,
         expectedLifeSpan integer not null,
         pastLife integer not null,
         isLive bool not null,
         reciptImage text not null,
         productImage text not null,
         residualValue integer,
         maintenanceCost integer)''';
