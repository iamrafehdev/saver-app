import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saver/Controllers/item_controller.dart';
import 'package:saver/UI/Components/item_widget.dart';
import 'package:saver/UI/Screens/widgets/custom_textfield.dart';
import 'package:saver/Utils/app_assets.dart';
import 'package:saver/widgets/app_button.dart';
import 'package:saver/widgets/app_icon_field.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';

import '../Components/heading_widget.dart';

class FindPage extends StatelessWidget {
  FindPage({super.key});

  TextEditingController textController = TextEditingController();

  bool isSearching = false;

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
                // Image.asset(
                //   AppAssetsImages.moreHorizIcon,
                //   width: 25,
                //   fit: BoxFit.fill,
                // ),
              ],
            ),
          ),
          body: GetBuilder<ItemController>(
            builder: (controller) => FutureBuilder(
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

                            // controller.searchedItems = controller.searchedItems.where((element)
                            // => element.name.toLowerCase().contains(query.toLowerCase())).toList();
                            // controller.update();

                            if(query.isEmpty){
                              isSearching = false;
                            }else{
                              controller.getFilterItems(query: query);
                              isSearching = true;

                            }

                            controller.update();
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
                            textController.clear();
                            isSearching = false;
                            FocusScope.of(context).unfocus();
                            controller.update();
                            // textController.clear();
                            // controller.searchItems(textController.text);
                            // FocusScope.of(context).unfocus();
                            // print("search");
                            // push(OnBoardingScreen());
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount:  isSearching  ? controller.searchedFilteredItems.length : controller.searchedItems.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var item = isSearching ?  controller.searchedFilteredItems[index] : controller.searchedItems[index];
                              if (controller.searchedItems.isEmpty) {
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
                                        model: item,
                                        screenSize: screenSize,
                                        heading:
                                            '${item.name}',
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
}
