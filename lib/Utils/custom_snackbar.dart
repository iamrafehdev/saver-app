import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

final SnackbarService customSnackBar = SnackbarService();
void setSnackBarStyle() {
  customSnackBar.registerSnackbarConfig(SnackbarConfig(
      textColor: Colors.white,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      messageColor: Colors.white,
      titleColor: Colors.white,
      messageTextStyle: const TextStyle(color: Colors.white)));
}
