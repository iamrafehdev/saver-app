import 'package:fialogs/fialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:req_fun/req_fun.dart';
import 'package:saver/Controllers/item_controller.dart';
import 'package:saver/Extensions/widget_extentions.dart';
import 'package:saver/Services/raw_data.dart';
import 'package:saver/UI/Screens/open_web_url.dart';
import 'package:saver/Utils/app_assets.dart';
import 'package:saver/Utils/app_theme.dart';
import 'package:saver/widgets/app_container.dart';
import 'package:saver/widgets/app_field.dart';
import 'package:saver/widgets/app_switch.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/popup_listview.dart';
import '../Custom Routes/Popups/show_pop_up.dart';
import 'widgets/table_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey _key = GlobalKey();
  String? _fullName;

  TextEditingController inflationController = TextEditingController();
  TextEditingController inflationDialogController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GetBuilder<ItemController>(
      builder: (controller) {
        inflationController.text = controller.inflation.toString();
        return Scaffold(
          floatingActionButton: AppContainer(
            onTap: () {
              push(HelpScreen());
            },
            width: MediaQuery.of(context).size.width * 0.5,
            color: AppTheme.PrimaryColor,
            child: Center(
                child: AppText(
              "Customer support",
              color: Colors.white,
            )),
            borderRadius: 16,
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            // leading:
            title: Row(
              children: [
                FlutterLogo(size: 24),
                SizeBoxWidth8(),
                AppText("Setting", bold: true, size: 20),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          singleInputDialog(
                            context,
                            "Update your name",
                            DialogTextField(
                              label: "Full Name",
                              hint: "please enter full name",
                              value: _fullName,
                              valueAutoSelected: true,
                              validator: Validator.required("Required!"),
                            ),
                            positiveButtonText: "Update",
                            positiveButtonAction: (value) async {
                              // _internetAndUpdateProfile(key: KEY_FIRST_NAME, value: value.trim());
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString('fullName', value);
                              _init();
                            },
                          );
                        },
                        child: Row(
                          children: [
                            SizeBoxWidth8(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _fullName == null
                                    ? AppText("Enter User Name", bold: true, size: 20.0)
                                    : AppText("$_fullName", bold: true, size: 20.0),
                                SizeBoxHeight8(),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              AppAssetsImages.editIcon,
                              height: 20,
                              width: 20,
                              // fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),

                      SizeBoxHeight32(),
                      InkWell(
                        onTap: () {
                          singleInputDialog(
                            context,
                            "Inflation",
                            DialogTextField(
                              label: "Inflation",
                              textInputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                              // value: _fullName,
                              valueAutoSelected: true,
                              // validator: Validator.required("Required!"),
                            ),
                            positiveButtonText: "Update",
                            positiveButtonAction: (val) {
                              controller.setinflation(double.parse(val));
                              FocusScope.of(context).unfocus();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                child: Image.asset(
                                  AppAssetsImages.inflationIcon,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizeBoxWidth8(),
                              AppText("Inflation", size: 16, bold: true),
                              Spacer(),
                              // AppText("1.0", size: 16, bold: true),
                              Container(
                                width: screenSize.width * 0.2,
                                // height: 20,
                                child: AppField(
                                  isEnable: false,
                                  // onTap: () {
                                  //   inflationController.clear();
                                  //   controller.inflation = 0;
                                  // },

                                  keyboardType: TextInputType.number,
                                  controller: inflationController,
                                  // controller: TextEditingController(
                                  //   text: controller.inflation.toString(),
                                  // ),
                                  // onChanged: (val) {
                                  //   if (val.isNotEmpty) {
                                  //     controller.setinflation(double.parse(val));
                                  //   }
                                  // },
                                ),
                              ),
                              SizeBoxWidth8(),
                              GestureDetector(
                                onTap: () {
                                  showAppDialog(
                                    context,
                                    "Inflation",
                                    RichText(
                                        text: const TextSpan(style: TextStyle(color: Colors.black54, fontSize: 16), children: [
                                      TextSpan(
                                          text:
                                              "If you depreciate your goods over a long period of time those goods will increase in price due to inflation. You can"),
                                      TextSpan(text: " adjust for inflation ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                      TextSpan(
                                        text: "by setting the expected inflation number here. ",
                                      ),
                                      TextSpan(text: "Every I-I of a new year ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                      TextSpan(text: "the inflation will be added to your total required savings amount"),
                                    ])),
                                  );
                                },
                                child: Icon(Icons.info, size: 20, color: Colors.black),
                              ),
                              SizeBoxWidth4(),
                            ],
                          ),
                        ),
                      ),
                      SizeBoxHeight4(),
                      InkWell(
                        onTap: () async {
                          controller.pickFile();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                child: Image.asset(
                                  AppAssetsImages.importBackupIcon,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizeBoxWidth8(),
                              AppText("Import Backup", size: 16, bold: true),
                              Spacer(),
                              Icon(Icons.add_box_rounded, size: 20, color: Colors.black),
                              SizeBoxWidth4(),
                            ],
                          ),
                        ),
                      ),
                      SizeBoxHeight4(),
                      GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          double left = details.globalPosition.dx;
                          double top = details.globalPosition.dy;
                          var res = await showPopUp(
                              context: context,
                              // rect: _key.location,
                              isRect: true,
                              left: left,
                              top: top,
                              padding: const EdgeInsets.only(top: 40),
                              child: PopupListView(dropdownValues: currenciesList, shouldIncludeSearchBar: true));
                          if (res is String) {
                            controller.setcurrency(res);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                child: Image.asset(
                                  AppAssetsImages.currencyIcon,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizeBoxWidth8(),
                              AppText("Currency", size: 16, bold: true),
                              Spacer(),
                              Container(
                                width: screenSize.width * 0.2,
                                // height: 20,
                                child: AppField(
                                  keyboardType: TextInputType.number,
                                  isEnable: false,
                                  controller: TextEditingController(
                                    text: controller.currency,
                                  ),
                                  onChanged: (val) {
                                    if (val.isNotEmpty) {
                                      controller.setinflation(double.parse(val));
                                    }
                                  },
                                ),
                              ),
                              SizeBoxWidth8(),
                              Icon(Icons.arrow_forward_ios_sharp, size: 20, color: Colors.black),
                              SizeBoxWidth4(),
                            ],
                          ),
                        ),
                      ),
                      SizeBoxHeight4(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 46,
                      //         height: 46,
                      //         child: Image.asset(
                      //           AppAssetsImages.moneyProgressIcon,
                      //           height: 40,
                      //           width: 40,
                      //           fit: BoxFit.fill,
                      //         ),
                      //       ),
                      //       SizeBoxWidth8(),
                      //       AppText("Money Progress", size: 16, bold: true),
                      //       Spacer(),
                      //       FlutterSwitch(
                      //         width: 40.0,
                      //         height: 22.0,
                      //         toggleSize: 12,
                      //         activeColor: Colors.blue,
                      //         inactiveColor: Colors.grey[300]!,
                      //         activeToggleColor: Colors.white,
                      //         toggleColor: Colors.white,
                      //         value: controller.moneyProgress.value,
                      //         onToggle: (value) {
                      //           // preferenceController.notification = value;
                      //           // preferenceController.update();
                      //           // preferenceController.notificationStatus(context, value);
                      //           controller.invertProgress();
                      //           setState(() {});
                      //         },
                      //       ),
                      //       SizeBoxWidth8(),
                      //       GestureDetector(
                      //           onTap: () {
                      //             showAppDialog(
                      //               context,
                      //               "Expected Lifespan",
                      //               RichText(
                      //                   text: const TextSpan(style: TextStyle(color: Colors.black54, fontSize: 16), children: [
                      //                 TextSpan(text: "Measures the progress of saving for replacement of items in money."),
                      //               ])),
                      //             );
                      //           },
                      //           child: Icon(Icons.info, size: 20, color: Colors.black)),
                      //       SizeBoxWidth4(),
                      //     ],
                      //   ),
                      // ),
                      // SizeBoxHeight4(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 46,
                      //         height: 46,
                      //         child: Image.asset(
                      //           AppAssetsImages.timeProgressIcon,
                      //           height: 40,
                      //           width: 40,
                      //           fit: BoxFit.fill,
                      //         ),
                      //       ),
                      //       SizeBoxWidth8(),
                      //       AppText("Time Progress", size: 16, bold: true),
                      //       Spacer(),
                      //       FlutterSwitch(
                      //         width: 40.0,
                      //         height: 22.0,
                      //         toggleSize: 12,
                      //         activeColor: Colors.blue,
                      //         inactiveColor: Colors.grey[300]!,
                      //         activeToggleColor: Colors.white,
                      //         toggleColor: Colors.white,
                      //         value: controller.timeProgress.value,
                      //         onToggle: (value) {
                      //           // preferenceController.notification = value;
                      //           // preferenceController.update();
                      //           // preferenceController.notificationStatus(context, value);
                      //           controller.invertProgress();
                      //           setState(() {});
                      //         },
                      //       ),
                      //       SizeBoxWidth8(),
                      //       GestureDetector(
                      //           onTap: () {
                      //             showAppDialog(
                      //               context,
                      //               "Time Progress",
                      //               RichText(
                      //                   text: const TextSpan(style: TextStyle(color: Colors.black54, fontSize: 16), children: [
                      //                 TextSpan(text: "Measures the progress of saving for replacement of items in time"),
                      //               ])),
                      //             );
                      //           },
                      //           child: Icon(Icons.info, size: 20, color: Colors.black)),
                      //       SizeBoxWidth4(),
                      //     ],
                      //   ),
                      // ),
                      SizeBoxHeight4(),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                child: Image.asset(
                                  AppAssetsImages.helpCenterIcon,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizeBoxWidth8(),
                              AppText("Help Center", size: 16, bold: true),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    showAppDialog(
                                      context,
                                      "Welcome to depreciate",
                                      RichText(
                                          text: const TextSpan(style: TextStyle(color: Colors.black54, fontSize: 16), children: [
                                        TextSpan(text: "Your goods depreciate in value, if you "),
                                        TextSpan(text: "save every month ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                        TextSpan(
                                          text: "for their replacement you can maintain your lifestyle. ",
                                        ),
                                        TextSpan(
                                            text: "Save the amount noted in the total saved bar ",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                        TextSpan(
                                            text:
                                                "on the main screen and you can infinitely replace your items. Open a seperate bank account and make sure you save the stated number."),
                                      ])),
                                    );
                                  },
                                  child: Icon(Icons.info, size: 20, color: Colors.black)),
                              SizeBoxWidth4(),
                            ],
                          ),
                        ),
                      ),
                      SizeBoxHeight4(),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                child: Image.asset(
                                  AppAssetsImages.privacyPolicyIcon,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizeBoxWidth8(),
                              AppText("Privacy Policy", size: 16, bold: true),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  showAppDialog(
                                    context,
                                    "Privacy policy",
                                    RichText(
                                        text: const TextSpan(style: TextStyle(color: Colors.black54, fontSize: 16), children: [
                                      TextSpan(text: "At Depriciate we believe in "),
                                      TextSpan(text: "privacy by design. ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                      TextSpan(
                                        text:
                                            "Our app stores everything locally on your phone. You can store your backup where ever you want. We will never be able to access any of your information.",
                                      ),
                                    ])),
                                  );
                                },
                                child: Icon(
                                  Icons.info,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizeBoxWidth4(),
                            ],
                          ),
                        ),
                      ),
                      SizeBoxHeight4(),
                      // InkWell (
                      //   onTap: (){
                      //
                      //     push(SecurityQuestionScreen()).then((value) {
                      //       profileController.clearSecurityQuestions();
                      //     });
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Row(
                      //       children: [
                      //         SizeBoxWidth8(),
                      //         AppIcon(icon: Icons.question_answer_outlined),
                      //         SizeBoxWidth8(),
                      //         AppText("Security Questions", size: 16),
                      //         Spacer(),
                      //         Icon(Icons.arrow_forward_ios_sharp, size: 20,color: Colors.grey),
                      //         SizeBoxWidth8(),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizeBoxHeight4(),
                      // InkWell(
                      //   onTap: (){
                      //     push(ChangePasswordScreen());
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Row(
                      //       children: [
                      //         SizeBoxWidth8(),
                      //         AppIcon(icon: Icons.lock_outline),
                      //         SizeBoxWidth8(),
                      //         AppText("Change Password", size: 16),
                      //         Spacer(),
                      //         Icon(Icons.arrow_forward_ios_sharp, size: 20,color: Colors.grey),
                      //         SizeBoxWidth8(),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizeBoxHeight4(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       SizeBoxWidth8(),
                      //       AppIcon(icon: Icons.privacy_tip_outlined),
                      //       SizeBoxWidth8(),
                      //       AppText("Notification", size: 16),
                      //       Spacer(),
                      //       FlutterSwitch(
                      //         width: 40.0,
                      //         height: 22.0,
                      //         toggleSize: 12,
                      //         activeColor: AppTheme.primaryColor,
                      //         inactiveColor: Colors.grey,
                      //         activeToggleColor: Colors.white,
                      //         toggleColor: Colors.white,
                      //         value: true,
                      //         onToggle: (value) {
                      //           // preferenceController.notification = value;
                      //           // preferenceController.update();
                      //           // preferenceController.notificationStatus(context, value);
                      //         },
                      //       ),
                      //       SizeBoxWidth8(),
                      //     ],
                      //   ),
                      // ),
                      // SizeBoxHeight4(),
                      // InkWell(
                      //   onTap: (){
                      //     push(PrivacyTermsScreen(page: 0));
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Row(
                      //       children: [
                      //         SizeBoxWidth8(),
                      //         AppIcon(icon: Icons.privacy_tip_outlined),
                      //         SizeBoxWidth8(),
                      //         AppText("Privacy", size: 16),
                      //         Spacer(),
                      //         Icon(Icons.arrow_forward_ios_sharp, size: 20,color: Colors.grey),
                      //         SizeBoxWidth8(),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizeBoxHeight4(),
                      // InkWell(
                      //   onTap: (){
                      //     push(PrivacyTermsScreen(page: 1));
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Row(
                      //       children: [
                      //         SizeBoxWidth8(),
                      //         AppIcon(icon: Icons.note_alt_sharp),
                      //         SizeBoxWidth8(),
                      //         AppText("Terms and Conditions", size: 16),
                      //         Spacer(),
                      //         Icon(Icons.arrow_forward_ios_sharp, size: 20,color: Colors.grey),
                      //         SizeBoxWidth8(),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizeBoxHeight4(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       SizeBoxWidth8(),
                      //       AppIcon(icon: Icons.help_outline),
                      //       SizeBoxWidth8(),
                      //       AppText("Help", size: 16),
                      //       Spacer(),
                      //       Icon(Icons.arrow_forward_ios_sharp, size: 20,color: Colors.grey),
                      //       SizeBoxWidth8(),
                      //     ],
                      //   ),
                      // ),
                      // SizeBoxHeight4(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       SizeBoxWidth8(),
                      //       AppIcon(icon: Icons.help_outline),
                      //       SizeBoxWidth8(),
                      //       AppText("Contact Your Employ", size: 16),
                      //       Spacer(),
                      //       Icon(Icons.arrow_forward_ios_sharp, size: 20,color: Colors.grey),
                      //       SizeBoxWidth8(),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  // Table(
                  //   border: TableBorder.all(color: Colors.black, width: 1.5),
                  //   columnWidths: const {
                  //     0: FlexColumnWidth(1),
                  //     1: FlexColumnWidth(1),
                  //     // 2: FlexColumnWidth(2),
                  //   },
                  //   children: [
                  //     CustomTextFieldRow(
                  //       title: "Inflation",
                  //       hintText: "Type here",
                  //       infoTitle: "Inflation",
                  //       allowBlanks: true,
                  //       keyboardType: TextInputType.number,
                  //       onChnage: (val) {
                  //         if (val.isNotEmpty) {
                  //           controller.setinflation(double.parse(val));
                  //         }
                  //       },
                  //       infoContent: RichText(
                  //           text: const TextSpan(
                  //               style:
                  //                   TextStyle(color: Colors.black54, fontSize: 16),
                  //               children: [
                  //             TextSpan(
                  //                 text:
                  //                     "If you depreciate your goods over a long period of time those goods will increase in price due to inflation. You can"),
                  //             TextSpan(
                  //                 text: " adjust for inflation ",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black)),
                  //             TextSpan(
                  //               text:
                  //                   "by setting the expected inflation number here. ",
                  //             ),
                  //             TextSpan(
                  //                 text: "Every I-I of a new year ",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black)),
                  //             TextSpan(
                  //                 text:
                  //                     "the inflation will be added to your total required savings amount"),
                  //           ])),
                  //       controller: TextEditingController(
                  //         text: controller.inflation.toString(),
                  //       ),
                  //     ),
                  //     // CustomTextFieldRow(
                  //     //     title: "Make Backup",
                  //     //     hintText: "Type here",
                  //     //     shouldSelectFile: true,
                  //     //     controller: TextEditingController(),
                  //     //     onTap: () async {
                  //     //       // var res = await ItemController.selectFile();
                  //     //       // if (res is String) {
                  //     //       //   reciptPhotoCont.text = res;
                  //     //       // }
                  //     //     }),
                  //     CustomTextFieldRow(
                  //         title: "Import Backup",
                  //         hintText: "Type here",
                  //         shouldSelectFile: true,
                  //         controller: TextEditingController(),
                  //         onTap: () async {
                  //           controller.pickFile();
                  //         }),
                  //     CustomTextFieldRow(
                  //       key: _key,
                  //       title: "Currency",
                  //       hintText: "Type here",
                  //       controller: TextEditingController(
                  //         text: controller.currency,
                  //       ),
                  //       onTap: () async {
                  //         var res = await showPopUp(
                  //             context: context,
                  //             rect: _key.location,
                  //             padding: const EdgeInsets.only(top: 40),
                  //             child: PopupListView(
                  //                 dropdownValues: currenciesList,
                  //                 shouldIncludeSearchBar: true));
                  //         if (res is String) {
                  //           controller.setcurrency(res);
                  //         }
                  //       },
                  //     ),
                  //     CustomRadioButtonRow(
                  //       title: "Money Progress",
                  //       value: controller.moneyProgress.value,
                  //       infoTitle: "Expected Lifespan",
                  //       info:
                  //           "Measures the progress of saving for replacement of items in money.",
                  //       onChange: (val) {
                  //         controller.invertProgress();
                  //       },
                  //     ),
                  //     CustomRadioButtonRow(
                  //       title: "Time progress",
                  //       value: controller.timeProgress.value,
                  //       infoTitle: "Time Progress",
                  //       info:
                  //           "Measures the progress of saving for replacement of items in time.",
                  //       onChange: (val) {
                  //         controller.invertProgress();
                  //       },
                  //     ),
                  //     CustomTextFieldRow(
                  //         title: "Help",
                  //         hintText: "How it works",
                  //         isReadOnly: true,
                  //         infoTitle: "Welcome to depreciate",
                  //         infoContent: RichText(
                  //             text: const TextSpan(
                  //                 style: TextStyle(
                  //                     color: Colors.black54, fontSize: 16),
                  //                 children: [
                  //               TextSpan(
                  //                   text:
                  //                       "Your goods depreciate in value, if you "),
                  //               TextSpan(
                  //                   text: "save every month ",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.black)),
                  //               TextSpan(
                  //                 text:
                  //                     "for their replacement you can maintain your lifestyle. ",
                  //               ),
                  //               TextSpan(
                  //                   text:
                  //                       "Save the amount noted in the total saved bar ",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.black)),
                  //               TextSpan(
                  //                   text:
                  //                       "on the main screen and you can infinitely replace your items. Open a seperate bank account and make sure you save the stated number."),
                  //             ])),
                  //         controller: TextEditingController()),
                  //     CustomTextFieldRow(
                  //         title: "Privacy policy",
                  //         infoTitle: "Privacy policy",
                  //         infoContent: RichText(
                  //             text: const TextSpan(
                  //                 style: TextStyle(
                  //                     color: Colors.black54, fontSize: 16),
                  //                 children: [
                  //               TextSpan(text: "At Depriciate we believe in "),
                  //               TextSpan(
                  //                   text: "privacy by design. ",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.black)),
                  //               TextSpan(
                  //                 text:
                  //                     "Our app stores everything locally on your phone. You can store your backup where ever you want. We will never be able to access any of your information.",
                  //               ),
                  //             ])),
                  //         hintText: "Our policy",
                  //         isReadOnly: true,
                  //         controller: TextEditingController()),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? fullNameFromPrefs = prefs.getString('fullName');
    print("fullNameFromPrefs $fullNameFromPrefs");
    if (fullNameFromPrefs != null) {
      _fullName = fullNameFromPrefs;
    } else {
      _fullName = null;
    }
    setState(() {});
  }

  showAppDialog(BuildContext context, String infoTitle, Widget content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(infoTitle),
              content: content,
              actions: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 20),
                    child: Text("Ok"),
                  ),
                )
              ],
            ));
  }

  addWeightDialog() {
    showGeneralDialog(
      context: context,
      barrierLabel: "Close",
      barrierDismissible: true,
      pageBuilder: (BuildContext context, a1, a2) {
        final _formKey = GlobalKey<FormState>();
        TextEditingController weightController = TextEditingController();
        return StatefulBuilder(
          builder: (ctx, sst) {
            // weightController.selection = TextSelection(
            //   baseOffset: 0,
            //   extentOffset: weight.toString().length,
            // );
            return Dialog(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizeBoxHeight16(),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: AppText("Inflation"),
                    ),
                    SizeBoxHeight16(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppField(
                              label: "",
                              autofocus: true,
                              controller: weightController,
                              // inputFormattersList:  [],
                              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.transparent,
                        //  height: MediaQuery.of(ctx).size.height * 0.08,
                        width: MediaQuery.of(ctx).size.width,
                        child: Center(
                          child: TextButton(
                            child: Text(
                              'Add ',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
