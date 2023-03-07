import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saver/UI/Components/seperator_widget.dart';
import 'package:saver/UI/Screens/find.dart';
import 'package:saver/UI/Screens/find2.dart';
import 'package:saver/UI/Screens/settings.dart';
import 'package:saver/UI/Screens/single_catagory.dart';
import 'package:saver/Utils/app_assets.dart';
import 'package:saver/widgets/app_icon_field.dart';
import 'package:saver/widgets/app_seekbar.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/item_controller.dart';
import '../../Controllers/tabs_controller.dart';
import '../../Models/catagory_model.dart';
import '../../Models/item_model.dart';
import '../Components/custom_bottom_navigation_bar.dart';
import '../Components/custom_scroll_behavior.dart';
import '../Components/item_widget.dart';
import 'add_item.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  String _fullName = "";

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? fullNameFromPrefs = prefs.getString('fullName');
    print("fullNameFromPrefs $fullNameFromPrefs");
    if (fullNameFromPrefs != null) {
      _fullName = fullNameFromPrefs;
    } else {
      _fullName = "";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: GetBuilder<ItemController>(
        builder: (controller) => FutureBuilder(
            future: controller.getAllItems(),
            builder: (context, snapshot) {
              // if (!snapshot.hasData) {
              //   return const Center(child: Text("no data Found"));
              // }
              // else if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              List<Map<CatagoryModel, List<ItemModel>>> data = snapshot.data ?? [];
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.3,
                        child: Image.asset(
                          AppAssetsImages.homeBg,
                          height: 70,
                          width: 70,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizeBoxHeight32(),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizeBoxWidth8(),
                                      _fullName.isEmpty
                                          ? AppText("User Name", bold: true, color: Colors.white, size: 22.0)
                                          : AppText("$_fullName", bold: true, color: Colors.white, size: 22.0),
                                    ],
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    child: Image.asset(
                                      AppAssetsImages.notificationIcon,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizeBoxHeight16(),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            SizeBoxHeight8(),
                            Padding(
                              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AppText("Saved", color: Colors.white),
                                            SizeBoxHeight8(),
                                            AppText("\$${controller.gettotalForAllCatagories().totalSavedAmount.toStringAsFixed(2)}",
                                                color: Colors.white, bold: true, size: 20.0),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AppText("Total", color: Colors.white),
                                            SizeBoxHeight8(),
                                            AppText("\$${controller.gettotalForAllCatagories().totalInflatedAmount.toStringAsFixed(2)}",
                                                color: Colors.white, bold: true, size: 20.0),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizeBoxHeight16(),
                                  Container(
                                    child: AppLinearProgress(
                                      value: controller.gettotalForAllCatagories().totalProgress,
                                      height: 12,
                                      color: Colors.blue.withOpacity(0.7),
                                      backgroundColor: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizeBoxHeight16(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // Get.to(SearchScreen());
                              Get.to(FindPage());
                            },
                            child: AppIconField(
                              controller: TextEditingController(),
                              label: "Search",
                              isEnabled: false,
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
                          SizeBoxHeight16(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText("Categories", size: 20.0, bold: true),
                              // AppText("See All", color: Colors.blue),
                            ],
                          ),
                          SizeBoxHeight8(),
                          Container(
                            height: 170.0,
                            width: screenSize.width,
                            child: data.isEmpty ? Center(child: AppText("Loading...", color: Colors.grey,)) : ListView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, catgoryIndex) => Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // HeadingWidget(
                                    //     text: data[catgoryIndex].keys.first.name),
                                    GestureDetector(
                                      onTap: () => Get.to(SingleCatagoryScreen(catagory: data[catgoryIndex])),
                                      child: ItemTotalWidget(
                                        screenSize: screenSize,
                                        model: controller.gettotalForCatagory(catgoryIndex),
                                        heading: '${data[catgoryIndex].keys.first.name}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300]!,
                                    blurRadius: 5.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizeBoxHeight8(),
                                    AppText("Monthly Saving should be: \$${controller.getTotalMonthlySavings().toStringAsFixed(1)}", size: 16.0),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: screenSize.width,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizeBoxHeight8(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppText("Savings in account should be", color: Colors.white, size: 12.0),
                                                      SizeBoxHeight8(),
                                                      Row(
                                                        children: [
                                                          AppText(
                                                            "\$${controller.gettotalForAllCatagories().totalSavedAmount.toStringAsFixed(1)}",
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            bold: true,
                                                          ),
                                                          // SizeBoxWidth4(),
                                                          // AppText("/month", color: Colors.white, size: 12.0),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.asset(
                                                    AppAssetsImages.savingsIcon,
                                                    height: 40,
                                                    width: 40,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // SizeBoxHeight8(),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
