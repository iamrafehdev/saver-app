import 'dart:io';

Future<File> saveDbFile(String path, String savePath) async {
  File file = File(path);
  return await File(savePath).writeAsBytes(file.readAsBytesSync());
}
