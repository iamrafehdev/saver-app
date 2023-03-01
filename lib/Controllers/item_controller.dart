import 'dart:math';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:saver/Models/catagory_model.dart';
import 'package:saver/Models/catagory_total_model.dart';
import 'package:saver/Models/item_model.dart';
import 'package:saver/Services/local_storage.dart';
import 'package:saver/Services/raw_data.dart';
import 'package:saver/Services/shared_prefrences_service.dart';
import 'package:saver/Utils/custom_snackbar.dart';

class ItemController extends GetxController {
  /// shared prefrences
  Rx<bool> moneyProgress = false.obs;
  Rx<bool> timeProgress = false.obs;
  double inflation = 0;
  String currency = "";


  //// services
  LocalStorageService localStorage;
  List<CatagoryModel> catagoriesList = [];
  List<Map<CatagoryModel, List<ItemModel>>> itemsInCatagories = [];
  List<ItemModel> searchedItems = [];

  ItemController(this.localStorage) {
    initializeDb();
    moneyProgress.value = SharedPrefrencesService.moneyProgress;
    timeProgress.value = SharedPrefrencesService.timeProgress;
    inflation = SharedPrefrencesService.inflation;
    currency = SharedPrefrencesService.currency;
  }

  /// Methods
  void addItem(ItemModel item) async {
    var res = await localStorage.addItem(item: item);
    if (res is bool) {
      customSnackBar.showSnackbar(message: "Item Successfully added");
      await addEventToCalendar(item);
    } else {
      customSnackBar.showSnackbar(message: "Failed with error $res");
    }
  }

  void deleteItem(ItemModel item) async {
    var res = await localStorage.deleteItem(item);
    if (res is bool) {
      customSnackBar.showSnackbar(message: "Item Successfully deleted");
      getAllItems(updateUi: true);
    }
  }

  void updateItem(ItemModel item) async {
    var res = await localStorage.updateItem(item: item);
    if (res is bool) {
      customSnackBar.showSnackbar(
          message:
              "Item Successfully updated, GO back to home page to refresh.");
      getAllItems(updateUi: true);
    } else {
      customSnackBar.showSnackbar(message: "Failed with error $res");
    }
  }

  Future<List<Map<CatagoryModel, List<ItemModel>>>> getAllItems(
      {bool updateUi = false}) async {
    List<ItemModel> res = await localStorage.getAllItems();
    itemsInCatagories = [];
    searchedItems = res;
    for (var i = 0; i < catagoriesList.length; i++) {
      List<ItemModel> items = [];
      items = res
          .where((element) => element.catagory == catagoriesList[i].name)
          .toList();
      itemsInCatagories.add(Map.from({catagoriesList[i]: items}));
    }
    if (updateUi) {
      update();
    }
    return itemsInCatagories;
  }

  void addCatagory(CatagoryModel item) async {
    var res = await localStorage.addCatagory(item: item);
    if (res is bool) {
      catagoriesList.add(item);
      customSnackBar.showSnackbar(message: "Catagory Successfully added");
    } else {
      customSnackBar.showSnackbar(
          message: "Failed with error $res",
          duration: const Duration(seconds: 10));
    }
  }

  Future getAllICatagories() async {
    var res = await localStorage.getAllCatagories();
    catagoriesList = res;
    catagoriesList.addAll(
        defaultCatagoriesList.map((e) => CatagoryModel(name: e)).toList());
    catagoriesList.sort((a, b) => a.name.compareTo(b.name));
    return res;
  }

  static Future<String?> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files.single.path;
    }
    return null;
  }

  void initializeDb() async {
    // await localStorage.initialise();
    // log("Database Initialized");
    await getAllICatagories();
  }

  void invertProgress() async {
    SharedPrefrencesService.moneyProgress = !moneyProgress.value;
    SharedPrefrencesService.timeProgress = !timeProgress.value;
    moneyProgress.value = !moneyProgress.value;
    timeProgress.value = !timeProgress.value;
    update();
  }

  void setinflation(double val) async {
    SharedPrefrencesService.inflation = val;
    inflation = val;
  }

  void setcurrency(String val) async {
    SharedPrefrencesService.currency = val;
    currency = val;
    update();
  }

  /// search Items

  void searchItems(String query) {
    List<ItemModel> queryItems = [];
    if (query.isEmpty) {
      for (var j = 0; j < itemsInCatagories.length; j++) {
        List<ItemModel> items =
            itemsInCatagories[j][itemsInCatagories[j].keys.first] ?? [];
        for (var i = 0; i < items.length; i++) {
          queryItems.add(items[i]);
        }
      }
      searchedItems = queryItems;
      update();
      return;
    }
    for (var j = 0; j < itemsInCatagories.length; j++) {
      List<ItemModel> items =
          itemsInCatagories[j][itemsInCatagories[j].keys.first] ?? [];
      for (var i = 0; i < items.length; i++) {
        if (items[i].name.toLowerCase().contains(query.toLowerCase())) {
          queryItems.add(items[i]);
        }
      }
    }
    searchedItems = queryItems;
    update();
  }

  /// item cataogories total
  CatagoryTotalModel gettotalForCatagory(int index) {
    CatagoryTotalModel total = CatagoryTotalModel(
        totalProgress: 0,
        totalSavedAmount: 0,
        totalInflatedAmount: 0,
        totalMonths: 0,
        totalMonthsPassed: 0);
    List<ItemModel> items =
        itemsInCatagories[index][itemsInCatagories[index].keys.first] ?? [];
    for (var i = 0; i < items.length; i++) {
      total.totalInflatedAmount += items[i].getInflatedAmount();
      total.totalSavedAmount += items[i].getSavings();
      total.totalMonths = items[i].expectedLifeSpan;
      total.totalMonthsPassed = items[i].getMonthsPassed().toInt();
    }
    total.totalProgress =
        max(total.totalSavedAmount, 0.1) / total.totalInflatedAmount * 100;
    return total;
  }

  CatagoryTotalModel gettotalForAllCatagories() {
    CatagoryTotalModel total = CatagoryTotalModel(
        totalProgress: 0,
        totalSavedAmount: 0,
        totalInflatedAmount: 0,
        totalMonths: 0,
        totalMonthsPassed: 0);
    for (var j = 0; j < itemsInCatagories.length; j++) {
      List<ItemModel> items =
          itemsInCatagories[j][itemsInCatagories[j].keys.first] ?? [];
      for (var i = 0; i < items.length; i++) {
        total.totalInflatedAmount += items[i].getInflatedAmount();
        total.totalSavedAmount += items[i].getSavings();
        total.totalMonths = items[i].expectedLifeSpan;
        total.totalMonthsPassed = items[i].getMonthsPassed().toInt();
      }
    }
    total.totalProgress =
        max(total.totalSavedAmount, 0.1) / total.totalInflatedAmount * 100;
    return total;
  }

  double getTotalMonthlySavings() {
    double savings = 0;
    for (var j = 0; j < itemsInCatagories.length; j++) {
      List<ItemModel> items =
          itemsInCatagories[j][itemsInCatagories[j].keys.first] ?? [];
      for (var i = 0; i < items.length; i++) {
        savings += items[i].getSaveAmount();
      }
    }
    return savings;
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      localStorage.importBackup(result.files.single.path!);
    }
  }

  addEventToCalendar(ItemModel item) async {
    DateTime date = DateTime.parse(item.datePurchased)
        .add(Duration(days: (30.5 * item.expectedLifeSpan).toInt()));
    final Event event = Event(
      title: "${item.name} LifeSpan Completed",
      description:
          "You should have saved ${item.getInflatedAmount().toStringAsFixed(1)}",
      // location: '',
      startDate: date,
      endDate: date,
    );
    await Add2Calendar.addEvent2Cal(event);
  }
}
