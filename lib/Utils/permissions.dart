import 'package:permission_handler/permission_handler.dart';

Future<bool> getStoragePermission() async {
  if (await Permission.manageExternalStorage.request().isGranted) {
    return true;
  } else {
    return false;
  }
}
