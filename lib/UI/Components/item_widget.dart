import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saver/Controllers/item_controller.dart';
import 'package:saver/Models/catagory_total_model.dart';
import 'package:saver/Models/item_model.dart';
import 'package:saver/Services/shared_prefrences_service.dart';
import 'package:saver/UI/Screens/add_item.dart';
import 'package:saver/Utils/app_assets.dart';
import 'package:saver/widgets/app_seekbar.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';

class ItemWidget extends StatelessWidget {
  ItemWidget({
    Key? key,
    required this.model,
    required this.screenSize,
    required this.heading,
  }) : super(key: key);
  final ItemModel model;
  final Size screenSize;
  final String heading;
  final ItemController controller = Get.find<ItemController>();

  @override
  Widget build(BuildContext context) {
    // double progressValue = min(model.getProgress() * 100, 100).toStringAsFixed(0)) == 0 ? :;
    double progressValue = (double.parse(model.getProgress().toStringAsFixed(0)));
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Get.to(AddItemScreen(item: model)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          blurRadius: 5.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      AppAssetsImages.vehiclesIcon,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizeBoxWidth16(),
                                  AppText("${heading}"),
                                ],
                              ),
                              Obx(() => controller.moneyProgress.value
                                  ? AppText("${model.getInflatedAmount().toStringAsFixed(1) + SharedPrefrencesService.currency}", color: Colors.blue)
                                  : AppText("${model.expectedLifeSpan}m", color: Colors.blue)),
                            ],
                          ),
                          SizeBoxHeight16(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: screenSize.width * 0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 1.0),
                                      child: Obx(() => controller.moneyProgress.value
                                          ? AppText(
                                              "${model.getSavings().toStringAsFixed(1)} ${SharedPrefrencesService.currency}/${(min(model.getProgress() * 100, 100)).toStringAsFixed(0)}%",
                                              size: 12.0)
                                          : AppText(
                                              "${model.getMonthsPassed().toInt()}m/${(min(model.getProgress() * 100, 100)).toStringAsFixed(0)}%",
                                              size: 12.0)),
                                    ),
                                    AppLinearProgress(
                                      value: progressValue > 0 ? progressValue : 0,
                                      height: 8.0,
                                      screenWidth: 0.6,
                                      color: Colors.green.withOpacity(0.9),
                                      backgroundColor: Colors.grey[200]!,
                                    ),
                                  ],
                                ),
                              ),
                              AppText("Saved", color: Colors.grey, size: 16.0),
                            ],
                          ),
                          SizeBoxHeight8(),
                        ],
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () => Get.to(AddItemScreen(item: model)),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.transparent,
                //       borderRadius: BorderRadius.circular(500),
                //       border: Border.all(color: Colors.black, width: 8),
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(500),
                //       child: Stack(
                //         clipBehavior: Clip.hardEdge,
                //         children: [
                //           Positioned(
                //             top: 0,
                //             right: (Get.width - 40) -
                //                 ((Get.width - 40) * model.getProgress() / 1),
                //             child: Container(
                //               height: 70,
                //               width: Get.width,
                //               decoration: BoxDecoration(
                //                 color: Colors.green[300],
                //                 borderRadius: BorderRadius.circular(100),
                //                 // border: Border.all(color: Colors.black, width: 5),
                //               ),
                //             ),
                //           ),
                //           Container(
                //             height: 70,
                //             padding: const EdgeInsets.symmetric(horizontal: 20),
                //             alignment: Alignment.center,
                //             child: Obx(
                //               () => controller.moneyProgress.value
                //                   ? Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Text(
                //                             "${model.getSavings().toStringAsFixed(1)} ${SharedPrefrencesService.currency}/${(min(model.getProgress() * 100, 100)).toStringAsFixed(0)}%"),
                //                         Text(model
                //                                 .getInflatedAmount()
                //                                 .toStringAsFixed(1) +
                //                             SharedPrefrencesService.currency),
                //                       ],
                //                     )
                //                   : Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Text(
                //                             "${model.getMonthsPassed().toInt()}m/${(min(model.getProgress() * 100, 100)).toStringAsFixed(0)}%"),
                //                         Text("${model.expectedLifeSpan}m"),
                //                       ],
                //                     ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemTotalWidget extends StatelessWidget {
  ItemTotalWidget({
    Key? key,
    required this.model,
    required this.screenSize,
    required this.heading,
  }) : super(key: key);
  final CatagoryTotalModel model;
  final Size screenSize;
  final String heading;
  final ItemController controller = Get.find<ItemController>();

  @override
  Widget build(BuildContext context) {
    // double progressValue = model.totalProgress;
    Size screenSize = MediaQuery.of(context).size;
    double progressValue = (double.parse(model.totalSavedAmount.toStringAsFixed(1)) == 0 ? 0 : min(model.totalProgress, 100));
    return Row(
      children: [
        Container(
          width: screenSize.width * 0.9,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300]!,
                        blurRadius: 5.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    heading == "Electronics"? AppAssetsImages.electronicsIcon :
                                    AppAssetsImages.vehiclesIcon,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizeBoxWidth16(),
                                AppText("${heading}"),
                              ],
                            ),
                            Obx(() => controller.moneyProgress.value
                                ? AppText("${model.totalInflatedAmount.toStringAsFixed(1)} ${SharedPrefrencesService.currency}", color: Colors.blue)
                                : AppText("${model.totalMonths}m", color: Colors.blue)),
                          ],
                        ),
                        SizeBoxHeight16(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenSize.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 1.0),
                                    child: Obx(() => controller.moneyProgress.value
                                        ? AppText(
                                            "${(double.parse(model.totalSavedAmount.toStringAsFixed(1)) == 0 ? 0 : min(model.totalProgress, 100)).toStringAsFixed(0)}% / ${model.totalSavedAmount.toStringAsFixed(1)} ${SharedPrefrencesService.currency}",
                                            size: 12.0)
                                        : AppText(
                                            "${model.totalMonthsPassed}m / ${(double.parse(model.totalSavedAmount.toStringAsFixed(1)) == 0 ? 0 : min(model.totalProgress, 100)).toStringAsFixed(0)}%",
                                            size: 12.0)),
                                  ),
                                  AppLinearProgress(
                                    value: progressValue > 0 ? progressValue : 0,
                                    height: 8.0,
                                    screenWidth: 0.6,
                                    color: Colors.green.withOpacity(0.9),
                                    backgroundColor: Colors.grey[200]!,
                                  ),
                                ],
                              ),
                            ),
                            AppText("Saved", color: Colors.grey, size: 16.0),
                          ],
                        ),
                        SizeBoxHeight8(),
                      ],
                    ),
                  ),
                ),
              ),
              // SizeBoxHeight16(),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.transparent,
              //     borderRadius: BorderRadius.circular(500),
              //     border: Border.all(color: Colors.black, width: 8),
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(500),
              //     child: Stack(
              //       clipBehavior: Clip.hardEdge,
              //       children: [
              //         Positioned(
              //           top: 0,
              //           right: (Get.width - 40) -
              //               ((Get.width - 40) * model.totalProgress / 100),
              //           child: Container(
              //             height: 70,
              //             width: Get.width,
              //             decoration: BoxDecoration(
              //               color: Colors.green[300],
              //               borderRadius: BorderRadius.circular(500),
              //               // border: Border.all(color: Colors.black, width: 5),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 70,
              //           padding: const EdgeInsets.symmetric(horizontal: 20),
              //           alignment: Alignment.center,
              //           child: Obx(
              //             () => controller.moneyProgress.value
              //                 ? Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                           "${model.totalSavedAmount.toStringAsFixed(1)} ${SharedPrefrencesService.currency}/${(double.parse(model.totalSavedAmount.toStringAsFixed(1)) == 0 ? 0 : min(model.totalProgress, 100)).toStringAsFixed(0)}%"),
              //                       Text(
              //                           "${model.totalInflatedAmount.toStringAsFixed(1)} ${SharedPrefrencesService.currency}"),
              //                     ],
              //                   )
              //                 : Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                           "${model.totalMonthsPassed}m/${(double.parse(model.totalSavedAmount.toStringAsFixed(1)) == 0 ? 0 : min(model.totalProgress, 100)).toStringAsFixed(0)}%"),
              //                       Text("${model.totalMonths}m"),
              //                     ],
              //                   ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
