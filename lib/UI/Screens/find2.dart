import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saver/Controllers/item_controller.dart';
import 'package:saver/Models/catagory_model.dart';
import 'package:saver/Models/item_model.dart';
import 'package:saver/Services/local_storage.dart';
import 'package:saver/UI/Components/item_widget.dart';
import 'package:saver/UI/Screens/widgets/custom_textfield.dart';
import 'package:saver/Utils/app_assets.dart';
import 'package:saver/widgets/app_button.dart';
import 'package:saver/widgets/app_icon_field.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';


class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ItemModel> searchedItems = [];

  LocalStorageService? localStorage;

  List<CatagoryModel> catagoriesList = [];

  List<Map<CatagoryModel, List<ItemModel>>> itemsInCatagories = [];

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    getAllItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.blue
            ),
            // leading:
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FlutterLogo(size: 24),
                    SizeBoxWidth8(),
                    AppText("Search", bold: true, size: 20),
                  ],
                ),
              ],
            ),
          ),
          body: GetBuilder<ItemController>(
            builder: (controllerx) => FutureBuilder(
                builder: (context, snapshot) {

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child:
                            AppIconField(
                          controller: textController,
                          onChanged: (query) {
                            searchedItems =searchedItems.where((element)
                            => element.name.toLowerCase().contains(query.toLowerCase())).toList();
                            setState(() {});
                          },
                          label: "Search",
                          prefixIcon: Icons.search,
                          suffixWidget: Align(
                            heightFactor: 1.0,
                            widthFactor: 1.0,
                            child: Image.asset(
                              AppAssetsImages.filterIcon,
                              height: 20.0,
                              width: 20.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          suffixIconPress: () {

                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount:searchedItems.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (searchedItems.isEmpty) {
                                return const Center(
                                  child: Text("No Item found"),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ItemWidget(
                                        model:searchedItems[index],
                                        screenSize: screenSize,
                                        heading:
                                            '${searchedItems[index].name}',
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Future<List<Map<CatagoryModel, List<ItemModel>>>> getAllItems(
      {bool updateUi = true}) async {
    List<ItemModel> res = await localStorage!.getAllItems();
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
     setState(() {});
    }
    return itemsInCatagories;
  }
}
