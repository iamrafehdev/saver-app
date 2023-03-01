import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saver/UI/Components/seperator_widget.dart';
import 'package:saver/UI/Screens/find.dart';
import 'package:saver/UI/Screens/home_screen.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {


  @override
  initState() {
    super.initState();
    /// initializing tab controller and settings
    TabController cont = TabController(length: CustomBottomNavBar.tabsList.length, vsync: this);
    TabsController tabCont = Get.find<TabsController>();
    cont.addListener(() {
      tabCont.changeIndex(cont.index);
    });
    tabCont.initializeController(cont);

  }





  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: const CustomBottomNavBar(),
          body: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: TabBarView(
              controller: controller.controller,
              children: [
                AddItemScreen(),
                HomeScreenWidget(),
                SettingsScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


