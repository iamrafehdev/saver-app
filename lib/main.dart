import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saver/Controllers/tabs_controller.dart';
import 'package:saver/Services/local_storage.dart';
import 'package:saver/Services/shared_prefrences_service.dart';
import 'package:saver/UI/Screens/home.dart';
import 'package:saver/UI/tabs/tab_view.dart';
import 'package:saver/Utils/custom_snackbar.dart';
import 'package:saver/Utils/permissions.dart';
import 'package:stacked_services/stacked_services.dart';

import 'Controllers/item_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var permission = await getStoragePermission();
  if (permission) {
    LocalStorageService localStorageService = LocalStorageService();
    await localStorageService.initialise();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white, systemNavigationBarColor: Colors.white));
    setSnackBarStyle();
    await SharedPrefrencesService.initialize();
    runApp(MyApp(
      localStorageService: localStorageService,
    ));
  } else {
    SystemNavigator.pop();
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.localStorageService});
  LocalStorageService localStorageService;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Depreciator',
      navigatorKey: StackedService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabsScreen(),
      // routes: {
      //   '/home': (context) => const HomeScreen(),
      // },
      onInit: () async {
        Get.put(TabsController());
        Get.put(ItemController(localStorageService));
      },
      initialRoute: "/home",
    );
  }
}
