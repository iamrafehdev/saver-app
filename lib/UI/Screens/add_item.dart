import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saver/Extensions/widget_extentions.dart';
import 'package:saver/Models/item_model.dart';
import 'package:saver/UI/Components/popup_listview.dart';
import 'package:saver/UI/Custom%20Routes/Popups/show_pop_up.dart';
import 'package:saver/Utils/app_assets.dart';
import 'package:saver/Utils/custom_snackbar.dart';
import 'package:saver/widgets/app_button.dart';
import 'package:saver/widgets/app_field.dart';
import 'package:saver/widgets/app_icon_field.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';

import '../../Controllers/item_controller.dart';
import '../../Models/catagory_model.dart';
import 'widgets/table_widgets.dart';

class AddItemScreen extends StatefulWidget {
  AddItemScreen({super.key, this.item});

  ItemModel? item;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  bool isLive = false;
  TextEditingController nameCont = TextEditingController();
  TextEditingController catagoryCont = TextEditingController();
  TextEditingController notesCont = TextEditingController();
  String datePurchase = "";
  String expiryDate = "";
  TextEditingController datePurchasedCont = TextEditingController();
  TextEditingController expiryDateCont = TextEditingController();
  TextEditingController purchaseAmountCont = TextEditingController();
  TextEditingController expectedLifeSpanCont = TextEditingController();
  TextEditingController pastLifeCont = TextEditingController(text: "0");
  TextEditingController productPhotoCont = TextEditingController();
  TextEditingController reciptPhotoCont = TextEditingController();
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      nameCont.text = widget.item!.name;
      catagoryCont.text = widget.item!.catagory;
      notesCont.text = widget.item!.notes;
      datePurchasedCont.text = widget.item!.datePurchased.substring(0, 10);
      expiryDateCont.text = widget.item!.expiryDate
          .substring(0, (widget.item?.expiryDate.length ?? 0) >= 10 ? 10 : 0);
      expectedLifeSpanCont.text = widget.item!.expectedLifeSpan.toString();
      isLive = widget.item!.isLive;
      datePurchase = widget.item!.datePurchased;
      expiryDate = widget.item!.expiryDate;
      purchaseAmountCont.text = widget.item!.purchaseAmount.toString();
      pastLifeCont.text = widget.item!.pastLife.toString();
      productPhotoCont.text = widget.item!.productImage;
      reciptPhotoCont.text = widget.item!.reciptImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            // leading:
            title: Row(
              children: [
                FlutterLogo(size: 24),
                SizeBoxWidth8(),
                AppText("Add", bold: true, size: 20),
              ],
            ),
          ),
          // appBar: widget.item != null
          //     ? AppBar(
          //         backgroundColor: const Color.fromARGB(255, 230, 228, 228),
          //         titleTextStyle:
          //             const TextStyle(color: Colors.black, fontSize: 20),
          //         iconTheme: const IconThemeData(color: Colors.black),
          //         title: Text(widget.item!.name))
          //     : null,
          body: GetBuilder<ItemController>(
            builder: (controller) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(
                      color: Colors.grey[400],
                    ),
                    SizeBoxHeight8(),
                    AppField(
                      controller: nameCont,
                      label: "Name",
                    ),
                    SizeBoxHeight8(),
                    GestureDetector(
                      onTapDown: (TapDownDetails details) async {
                        double left = details.globalPosition.dx;
                        double top = details.globalPosition.dy;
                        var res = await showPopUp(
                            context: context,
                            // rect: _key.location,
                            isRect: true,
                            left: left,
                            top: top -22,
                            padding: const EdgeInsets.only(top: 40),
                            child: PopupListView(
                                dropdownValues: controller.catagoriesList
                                    .map((e) => e.name)
                                    .toList(),
                                shouldIncludeSearchBar: true));
                        if (res is String) {
                          catagoryCont.text = res;
                          setState(() {});
                        }
                      },
                      child: AppField(
                        controller: catagoryCont,
                        isEnable: false,
                        label: "Category",
                      ),
                    ),
                    SizeBoxHeight8(),
                    AppField(
                      controller: notesCont,
                      label: "Notes",
                    ),
                    SizeBoxHeight8(),
                    InkWell(
                      onTap: () async {
                        var res = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365 * 50)),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 365 * 50)));
                        if (res is DateTime) {
                          datePurchase = res.toIso8601String();
                          datePurchasedCont.text =
                              DateFormat("dd-MM-yyyy").format(res);

                          setState(() {});
                        }
                      },
                      child: AppField(
                        controller: datePurchasedCont,
                        label: "Date Purchase",
                        suffixIcon: Icons.add_box,
                        isEnable: false,
                      ),
                    ),
                    SizeBoxHeight8(),
                    AppField(
                      controller: purchaseAmountCont,
                      label: "Purchase Amount",
                      keyboardType: TextInputType.number,
                    ),
                    SizeBoxHeight8(),
                    AppField(
                      controller: expectedLifeSpanCont,
                      label: "Expected Lifespan",
                      keyboardType: TextInputType.number,
                    ),
                    SizeBoxHeight8(),
                    AppField(
                      label: "Past Life",
                      isEnable: false,
                      controller: TextEditingController(
                        text: datePurchasedCont.text.isNotEmpty
                            ? max(
                                    DateTime.now()
                                            .difference(
                                                DateTime.parse(datePurchase))
                                            .inDays ~/
                                        30,
                                    0)
                                .toStringAsFixed(0)
                            : "0",
                      ),
                    ),
                    SizeBoxHeight8(),
                    InkWell(
                      onTap: () async {
                        var res = await ItemController.selectFile();
                        if (res is String) {
                          productPhotoCont.text = res;
                          setState(() {});
                        }
                      },
                      child: AppField(
                        controller: productPhotoCont,
                        label: "Product Photo",
                        suffixIcon: Icons.photo,
                        isEnable: false,
                      ),
                    ),
                    SizeBoxHeight8(),
                    InkWell(
                      onTap: () async {
                        var res = await ItemController.selectFile();
                        if (res is String) {
                          reciptPhotoCont.text = res;
                          setState(() {});
                        }
                      },
                      child: AppField(
                        controller: reciptPhotoCont,
                        label: "Receipt Photo",
                        suffixIcon: Icons.photo,
                        isEnable: false,
                      ),
                    ),
                    SizeBoxHeight8(),
                    AppField(
                        keyboardType: TextInputType.number,
                        hint: "0",
                        label: "Save Per Month",
                        controller: TextEditingController(
                          text: purchaseAmountCont.text.isNotEmpty &&
                                  expectedLifeSpanCont.text.isNotEmpty
                              ? max(
                                      (double.parse(purchaseAmountCont.text) /
                                          int.parse(expectedLifeSpanCont.text)),
                                      0)
                                  .toStringAsFixed(2)
                              : "0",
                        )),
                    SizeBoxHeight8(),
                    InkWell(
                      onTap: () async {
                        var res = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365 * 50)),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 365 * 50)));
                        if (res is DateTime) {
                          expiryDate = res.toIso8601String();
                          expiryDateCont.text =
                              DateFormat("dd-MM-yyyy").format(res);
                          setState(() {});
                        }
                      },
                      child: AppField(
                        isEnable: false,
                        controller: expiryDateCont,
                        label: "Expiration Date",
                        suffixIcon: Icons.add_box,
                      ),
                    ),

                    // Table(
                    //   border: TableBorder.all(color: Colors.black, width: 1.5),
                    //   columnWidths: const {
                    //     0: FlexColumnWidth(1),
                    //     1: FlexColumnWidth(1),
                    //     // 2: FlexColumnWidth(2),
                    //   },
                    //   children: [
                    //     CustomTextFieldRow(
                    //         title: "Name",
                    //         hintText: "Type here",
                    //         controller: nameCont),
                    //     CustomTextFieldRow(
                    //       key: _key,
                    //       title: "Category",
                    //       hintText: "Type here",
                    //       controller: catagoryCont,
                    //       onTap: () async {
                    //         var res = await showPopUp(
                    //             context: context,
                    //             rect: _key.location,
                    //             padding: const EdgeInsets.only(top: 40),
                    //             child: PopupListView(
                    //                 dropdownValues: controller.catagoriesList
                    //                     .map((e) => e.name)
                    //                     .toList(),
                    //                 shouldIncludeSearchBar: true));
                    //         if (res is String) {
                    //           catagoryCont.text = res;
                    //           setState(() {});
                    //         }
                    //       },
                    //     ),
                    //     CustomTextFieldRow(
                    //         title: "Notes",
                    //         hintText: "Type here",
                    //         controller: notesCont),
                    //     CustomTextFieldRow(
                    //         title: "Date Purchased",
                    //         hintText: "Select Data",
                    //         shouldSelectFile: true,
                    //         onTap: () async {
                    //           var res = await showDatePicker(
                    //               context: context,
                    //               initialDate: DateTime.now(),
                    //               firstDate: DateTime.now()
                    //                   .subtract(const Duration(days: 365 * 50)),
                    //               lastDate: DateTime.now()
                    //                   .add(const Duration(days: 365 * 50)));
                    //           if (res is DateTime) {
                    //             datePurchase = res.toIso8601String();
                    //             datePurchasedCont.text =
                    //                 DateFormat("dd-MM-yyyy").format(res);
                    //
                    //             setState(() {});
                    //           }
                    //         },
                    //         controller: datePurchasedCont),
                    //     CustomTextFieldRow(
                    //       title: "Purchase Amount",
                    //       hintText: "Type here",
                    //       keyboardType: TextInputType.number,
                    //       controller: purchaseAmountCont,
                    //       onChnage: (p0) {
                    //         setState(() {});
                    //       },
                    //     ),
                    //     CustomTextFieldRow(
                    //       title: "Expected Lifespan",
                    //       hintText: "Type here",
                    //       keyboardType: TextInputType.number,
                    //       controller: expectedLifeSpanCont,
                    //       onChnage: (p0) {
                    //         setState(() {});
                    //       },
                    //     ),
                    //     // CustomRadioButtonRow(
                    //     //   title: "is Live/ not Live",
                    //     //   value: isLive,
                    //     //   onChange: (val) {
                    //     //     setState(() {
                    //     //       isLive = !isLive;
                    //     //     });
                    //     //   },
                    //     // ),
                    //     CustomTextFieldRow(
                    //         title: "Past Life",
                    //         hintText: "Type here",
                    //         keyboardType: TextInputType.number,
                    //         onTap: () {},
                    //         controller: TextEditingController(
                    //           text: datePurchasedCont.text.isNotEmpty
                    //               ? max(
                    //                       DateTime.now()
                    //                               .difference(DateTime.parse(
                    //                                   datePurchase))
                    //                               .inDays ~/
                    //                           30,
                    //                       0)
                    //                   .toStringAsFixed(0)
                    //               : "0",
                    //         )),
                    //     CustomTextFieldRow(
                    //         title: "Product Photo",
                    //         hintText: "Type here",
                    //         shouldSelectFile: true,
                    //         controller: productPhotoCont,
                    //         onTap: () async {
                    //           var res = await ItemController.selectFile();
                    //           if (res is String) {
                    //             productPhotoCont.text = res;
                    //             setState(() {});
                    //           }
                    //         }),
                    //     CustomTextFieldRow(
                    //         title: "Receipt Photo",
                    //         hintText: "Type here",
                    //         shouldSelectFile: true,
                    //         controller: reciptPhotoCont,
                    //         onTap: () async {
                    //           var res = await ItemController.selectFile();
                    //           if (res is String) {
                    //             reciptPhotoCont.text = res;
                    //             setState(() {});
                    //           }
                    //         }),
                    //     CustomTextFieldRow(
                    //         title: "Save Per Month",
                    //         hintText: "0",
                    //         // shouldSelectFile: true,
                    //         controller: TextEditingController(
                    //           text: purchaseAmountCont.text.isNotEmpty &&
                    //                   expectedLifeSpanCont.text.isNotEmpty
                    //               ? max(
                    //                       (double.parse(
                    //                               purchaseAmountCont.text) /
                    //                           int.parse(
                    //                               expectedLifeSpanCont.text)),
                    //                       0)
                    //                   .toStringAsFixed(2)
                    //               : "0",
                    //         )),
                    //     CustomTextFieldRow(
                    //         title: "Add Expiration to Calendar",
                    //         hintText: "Type here",
                    //         shouldSelectFile: true,
                    //         onTap: () async {
                    //           var res = await showDatePicker(
                    //               context: context,
                    //               initialDate: DateTime.now(),
                    //               firstDate: DateTime.now()
                    //                   .subtract(const Duration(days: 365 * 50)),
                    //               lastDate: DateTime.now()
                    //                   .add(const Duration(days: 365 * 50)));
                    //           if (res is DateTime) {
                    //             expiryDate = res.toIso8601String();
                    //             expiryDateCont.text =
                    //                 DateFormat("dd-MM-yyyy").format(res);
                    //             setState(() {});
                    //           }
                    //         },
                    //         controller: expiryDateCont),
                    //   ],
                    // ),
                    SizeBoxHeight16(),
                    if (widget.item != null)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  text: "Update",
                                  textSize: 20.0,
                                  borderRadius: 14.0,
                                  height: 45.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  btnColor: Colors.blue,
                                  onPressed: () {
                                    ItemModel item = ItemModel(
                                      id: widget.item!.id,
                                      dateAdded: widget.item!.dateAdded,
                                      name: nameCont.text,
                                      catagory: catagoryCont.text,
                                      datePurchased: datePurchase,
                                      expectedLifeSpan:
                                          int.parse(expectedLifeSpanCont.text),
                                      isLive: isLive,
                                      notes: notesCont.text,
                                      pastLife: int.parse(pastLifeCont.text),
                                      productImage: productPhotoCont.text,
                                      purchaseAmount:
                                          double.parse(purchaseAmountCont.text),
                                      reciptImage: reciptPhotoCont.text,
                                      expiryDate: expiryDate,
                                    );
                                    if (widget.item != item) {
                                      print(widget.item.toString());
                                      print(item.toString());
                                      controller.updateItem(item);
                                    }
                                  },
                                ),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     ItemModel item = ItemModel(
                                //       id: widget.item!.id,
                                //       dateAdded: widget.item!.dateAdded,
                                //       name: nameCont.text,
                                //       catagory: catagoryCont.text,
                                //       datePurchased: datePurchase,
                                //       expectedLifeSpan:
                                //           int.parse(expectedLifeSpanCont.text),
                                //       isLive: isLive,
                                //       notes: notesCont.text,
                                //       pastLife: int.parse(pastLifeCont.text),
                                //       productImage: productPhotoCont.text,
                                //       purchaseAmount:
                                //           double.parse(purchaseAmountCont.text),
                                //       reciptImage: reciptPhotoCont.text,
                                //       expiryDate: expiryDate,
                                //     );
                                //     if (widget.item != item) {
                                //       print(widget.item.toString());
                                //       print(item.toString());
                                //       controller.updateItem(item);
                                //     }
                                //   },
                                //   style: ButtonStyle(
                                //     backgroundColor: MaterialStateProperty.all(
                                //       Colors.orange,
                                //     ),
                                //   ),
                                //   child: const Text("Update"),
                                // ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: AppButton(
                                text: 'Delete',
                                textSize: 20.0,
                                borderRadius: 14.0,
                                height: 45.0,
                                width: MediaQuery.of(context).size.width * 0.9,
                                btnColor: Colors.red,
                                onPressed: () {
                                  customSnackBar.showSnackbar(
                                    title: "Delete?",
                                    message:
                                        "Are you sure ypu want to delete this item?",
                                    mainButtonTitle: "Confirm",
                                    onMainButtonTapped: () async {
                                      controller.deleteItem(widget.item!);
                                      Get.until((route) =>
                                          Get.currentRoute == "/home");
                                      Get.back();
                                    },
                                  );
                                },
                              )
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     customSnackBar.showSnackbar(
                                  //       title: "Delete?",
                                  //       message:
                                  //           "Are you sure ypu want to delete this item?",
                                  //       mainButtonTitle: "Confirm",
                                  //       onMainButtonTapped: () async {
                                  //         controller.deleteItem(widget.item!);
                                  //         Get.until((route) =>
                                  //             Get.currentRoute == "/home");
                                  //         Get.back();
                                  //       },
                                  //     );
                                  //   },
                                  //   style: ButtonStyle(
                                  //     backgroundColor: MaterialStateProperty.all(
                                  //         const Color.fromARGB(255, 224, 78, 67)),
                                  //   ),
                                  //   child: const Text("Delete"),
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      ),

                    if (widget.item == null)
                      Row(
                        children: [
                          Expanded(
                              child: AppButton(
                            text: "Add",
                            textSize: 20.0,
                            borderRadius: 14.0,
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.9,
                            btnColor: Colors.blue,
                            onPressed: () {
                              if (nameCont.text.isEmpty ||
                                  catagoryCont.text.isEmpty ||
                                  datePurchasedCont.text.isEmpty ||
                                  purchaseAmountCont.text.isEmpty ||
                                  expectedLifeSpanCont.text.isEmpty) {
                                customSnackBar.showSnackbar(
                                  title: "Sorry",
                                  message:
                                      "Please Enter all the Required Fields.\nName, Category, Date Purchased, Purchase Amount and Expected Lifespan",
                                );
                                return;
                              }
                              ItemModel item = ItemModel(
                                dateAdded: DateTime.now().toIso8601String(),
                                name: nameCont.text,
                                catagory: catagoryCont.text,
                                datePurchased: datePurchase,
                                expectedLifeSpan:
                                    int.parse(expectedLifeSpanCont.text),
                                isLive: isLive,
                                notes: notesCont.text,
                                pastLife: int.parse(pastLifeCont.text),
                                productImage: productPhotoCont.text,
                                purchaseAmount:
                                    double.parse(purchaseAmountCont.text),
                                reciptImage: reciptPhotoCont.text,
                                expiryDate: expiryDate,
                              );
                              controller.addItem(item);
                              resetControllers();
                            },
                          )),
                        ],
                      ),
                    SizeBoxHeight8(),
                    if (widget.item == null)
                      Row(
                        children: [
                          Expanded(
                              child: AppButton(
                            text: 'Add new Category',
                            textSize: 20.0,
                            borderRadius: 14.0,
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.9,
                            btnColor: Colors.orange,
                            onPressed: () async {
                              TextEditingController cont =
                                  TextEditingController();
                              var res = await addNewCatagory(context, cont);
                              if (res is bool) {
                                Get.find<ItemController>().addCatagory(
                                    CatagoryModel(
                                        name: cont.text.removeAllWhitespace));
                              }
                            },
                          )),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetControllers() {
    nameCont.clear();
    catagoryCont.clear();
    notesCont.clear();
    datePurchase = "";
    datePurchasedCont.clear();
    expiryDate = "";
    expiryDateCont.clear();
    purchaseAmountCont.clear();
    expectedLifeSpanCont.clear();
    productPhotoCont.clear();
    reciptPhotoCont.clear();
    setState(() {});
  }
}

Future<dynamic> addNewCatagory(
    BuildContext context, TextEditingController cont) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Add Catagory"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              controller: cont,
              decoration: const InputDecoration(hintText: "Type Here")),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text("Add"),
                onPressed: () {
                  if (cont.text.isNotEmpty) {
                    return Get.back(result: true);
                  }
                  // Get.back();
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 224, 78, 67)),
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
