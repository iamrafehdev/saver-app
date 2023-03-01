import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saver/Controllers/item_controller.dart';
import 'package:saver/UI/Components/item_widget.dart';
import 'package:saver/UI/Screens/widgets/custom_textfield.dart';
import 'package:saver/Utils/app_assets.dart';
import 'package:saver/widgets/app_icon_field.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';

import '../Components/heading_widget.dart';

class FindPage extends StatelessWidget {
  FindPage({super.key});

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
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
              future: controller.getAllItems(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text("no data Found"));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child:
                          // CustomTextField(
                          //   hintText: "Search Here",
                          //   onChange: (query) {
                          //     controller.searchItems(query);
                          //   },
                          //   controller: textController,
                          // ),
                          AppIconField(
                        controller: textController,
                        // onChanged: (query) {
                        //   controller.searchItems(query);
                        // },
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
                          print("search");
                          // push(OnBoardingScreen());
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller.searchedItems.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
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
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 10),
                                    //   child: HeadingWidget(
                                    //       text: controller
                                    //           .searchedItems[index].name),
                                    // ),
                                    ItemWidget(
                                      model: controller.searchedItems[index],
                                      screenSize: screenSize,
                                      heading:
                                          '${controller.searchedItems[index].name}',
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
    );
  }
}
