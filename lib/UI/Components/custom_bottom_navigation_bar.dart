import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Controllers/tabs_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
  }) : super(key: key);
  static List<Map> tabsList = [
    {"Add": Icons.add},
    {"Home": Icons.home},
    {"Settings": Icons.settings}
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(
      builder: (controller) => AnimatedBottomNavigationBar.builder(
        itemCount: tabsList.length,
        backgroundColor: Colors.white,
        activeIndex: controller.activeIndex,
        splashColor: Colors.blue,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.none,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        height: 70,
        onTap: (index) {
          controller.changeTab(index: index);
        },
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.blue : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (tabsList[index])[tabsList[index].keys.first]!,
                size: 30,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  tabsList[index].keys.first,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
