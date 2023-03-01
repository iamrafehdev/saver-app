import 'package:flutter/material.dart';
import 'package:saver/UI/Screens/add_item.dart';
import 'package:saver/UI/Screens/home.dart';
import 'package:saver/UI/Screens/home_screen.dart';
import 'package:saver/UI/Screens/settings.dart';
import 'package:saver/Utils/app_theme.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';


class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 1;

  List<Widget> widgetOptions = <Widget>[
    AddItemScreen(),
    HomeScreenWidget(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: Container(
          height: 60,
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizeBoxWidth16(),
              SizeBoxWidth8(),
              InkWell(
                onTap: () {
                  onItemTapped(0);
                },
                child: Column(
                  children: [
                    SizeBoxHeight4(),
                    SizeBoxHeight2(),
                    Icon(Icons.add, color: selectedIndex == 0 ? AppTheme.PrimaryColor : Colors.grey, size: 28),
                    SizeBoxHeight2(),
                    AppText(
                      "Add",
                      size: 16,
                    )
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  onItemTapped(1);
                },
                child: Column(
                  children: [
                    SizeBoxHeight4(),
                    SizeBoxHeight2(),
                    Icon(Icons.home, color: selectedIndex == 1 ? AppTheme.PrimaryColor : Colors.grey, size: 28),
                    SizeBoxHeight2(),
                    AppText(
                      "Home",
                      size: 16,
                    )
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  onItemTapped(2);
                },
                child: Column(
                  children: [
                    SizeBoxHeight4(),
                    SizeBoxHeight2(),
                    Icon(Icons.settings, color: selectedIndex == 2 ? AppTheme.PrimaryColor : Colors.grey, size: 28),
                    SizeBoxHeight2(),
                    AppText(
                      "Setting",
                      size: 16,
                    )
                  ],
                ),
              ),
              SizeBoxWidth16(),
              SizeBoxWidth8(),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              boxShadow:
              [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ]
          ),
        ));
  }

  init() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final homeController = Provider.of<TabsController>(context, listen: false);
    // });
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    setState(() {});
  }
}
