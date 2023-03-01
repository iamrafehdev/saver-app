import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsController extends GetxController {
  /// Variables
  late TabController controller;
  int activeIndex = 1;

  /// Methods

  initializeController(TabController con) {
    controller = con;
  }

  /// change tabs with animating the bottom bar active index
  changeTab({int index = 1}) {
    controller.animateTo(index);
  }

  /// only updates the active index color
  changeIndex(int index) {
    activeIndex = index;
    update();
  }
}
