// import 'package:fialogs/fialogs.dart';
// import 'package:flutter/material.dart';
//
// class PopupListView extends StatefulWidget {
//   const PopupListView({super.key, this.dropdownValues, required this.shouldIncludeSearchBar});
//
//   final bool shouldIncludeSearchBar;
//   final List<String>? dropdownValues;
//
//   @override
//   State<PopupListView> createState() => _PopupListViewState();
// }
//
// class _PopupListViewState extends State<PopupListView> {
//   List<String>? searchedValues = [];
//   TextEditingController cont = TextEditingController();
//   FocusNode node = FocusNode();
//
//   @override
//   void initState() {
//     super.initState();
//     searchedValues = widget.dropdownValues;
//     node.addListener(() {
//       setState(() {});
//     });
//   }
//
//   void search(String search) {
//     if (search.isEmpty) {
//       searchedValues = widget.dropdownValues;
//     } else {
//       searchedValues = widget.dropdownValues!.where((element) => element.toLowerCase().contains(search.toLowerCase())).toList();
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(minHeight: 200, maxHeight: 400),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black26)),
//       width: MediaQuery.of(context).size.width*0.7,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (widget.shouldIncludeSearchBar)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: cont,
//                 focusNode: node,
//                 decoration: const InputDecoration(hintText: "Search here"),
//                 onChanged: (value) {
//                   search(value);
//                 },
//               ),
//             ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: searchedValues!.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) => ListTile(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(searchedValues![index]),
//                     IconButton(
//                       onPressed: () {
//                         warningDialog(
//                           context,
//                           "Alert",
//                           "Are you sure you want to delete this category?",
//                           hideNeutralButton: true,
//                           positiveButtonText: "Yes",
//                           positiveButtonAction: () {
//                             print("${searchedValues![index]}");
//
//                           },
//                           negativeButtonText: "No",
//                           negativeButtonAction: () {},
//                         );
//                       },
//                       icon: Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//                 onTap: () => Navigator.pop(context, searchedValues![index]),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:fialogs/fialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:req_fun/req_fun.dart';
import 'package:saver/Controllers/item_controller.dart';
import 'package:saver/Models/catagory_model.dart';
import 'package:saver/Services/local_storage.dart';

class PopupListView extends StatefulWidget {
  final List<CatagoryModel>? catagoryModel;
  final ItemController? itemController;
  final bool isDelete;
  final bool shouldIncludeSearchBar;
  final List<String>? dropdownValues;

  const PopupListView(
      {super.key, this.dropdownValues, required this.shouldIncludeSearchBar, this.catagoryModel, this.isDelete = false, this.itemController});

  @override
  State<PopupListView> createState() => _PopupListViewState();
}

class _PopupListViewState extends State<PopupListView> {
  List<String>? searchedValues = [];
  TextEditingController cont = TextEditingController();
  FocusNode node = FocusNode();
  LocalStorageService localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    searchedValues = widget.dropdownValues;
    node.addListener(() {
      setState(() {});
    });
  }

  void search(String search) {
    if (search.isEmpty) {
      searchedValues = widget.dropdownValues;
    } else {
      searchedValues = widget.dropdownValues!.where((element) => element.toLowerCase().contains(search.toLowerCase())).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 250),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black26)),
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.shouldIncludeSearchBar)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cont,
                focusNode: node,
                decoration: const InputDecoration(hintText: "Search here"),
                onChanged: (value) {
                  search(value);
                },
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedValues!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                title: Text(searchedValues![index]),
                trailing: widget.isDelete == true
                    ? InkWell(
                        onTap: () {
                          pop();
                          infoDialog(context, "Delete", "Are you sure you want to delete this category?",
                              positiveButtonText: "No",
                              positiveButtonAction: () {
                                pop();
                              },
                              neutralButtonText: "Yes",
                              neutralButtonAction: () async {
                                // print("${ widget.itemController!.catagoriesList[7].name}");

                                Get.find<ItemController>().deleteCategory(widget.catagoryModel![index]);

                                // Get.until((route) => Get.currentRoute == "/home");
                                // Get.back();
                                // widget.itemController!.deleteCategory(widget.catagoryModel![index]);
                                // pop();
                              });
                        },
                        child: Icon(Icons.delete_outline, color: Colors.red))
                    : null,
                onTap: () => Navigator.pop(context, searchedValues![index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
