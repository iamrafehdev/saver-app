import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

TableRow CustomTextFieldRow({
  required String title,
  required String hintText,
  required TextEditingController controller,
  Function(String)? onChnage,
  Function()? onTap,
  Key? key,
  Widget? infoContent,
  String? infoTitle,
  bool isReadOnly = false,
  bool shouldSelectFile = false,
  TextInputType? keyboardType,
  bool allowBlanks = false,
}) {
  return TableRow(children: [
    TextRowWidget(
      title: title,
    ),
    TextFieldRowWidget(
      key: key,
      controller: controller,
      hintText: hintText,
      onChange: onChnage,
      shouldSelectFile: shouldSelectFile,
      onTap: onTap,
      isReadOnly: isReadOnly,
      content: infoContent,
      infoTitle: infoTitle,
      keyboardType: keyboardType,
      allowBlanks: allowBlanks,
    )
  ]);
}

TableRow CustomRadioButtonRow({
  required String title,
  required bool value,
  required void Function(bool?) onChange,
  String? info,
  String? infoTitle,
}) {
  return TableRow(children: [
    TextRowWidget(
      title: title,
    ),
    Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Switch(value: value, onChanged: onChange),
        if (info != null)
          Positioned(
            top: 10,
            right: 10,
            child: Builder(
              builder: (context) => GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(infoTitle!),
                              content: Text(info),
                              actions: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 10, right: 20),
                                    child: Text("Ok"),
                                  ),
                                )
                              ],
                            ));
                  },
                  child: const Icon(Icons.info)),
            ),
          ),
      ],
    )
  ]);
}

class TextRowWidget extends StatelessWidget {
  const TextRowWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(title, style: const TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class TextFieldRowWidget extends StatelessWidget {
  TextFieldRowWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.shouldSelectFile,
    required this.isReadOnly,
    this.allowBlanks = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.content,
    this.infoTitle,
    this.onChange,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final bool shouldSelectFile;
  final bool isReadOnly;
  final TextInputType? keyboardType;
  final bool allowBlanks;
  Function(String)? onChange;
  Function()? onTap;
  Widget? content;
  String? infoTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: shouldSelectFile && controller.text.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    child: Icon(Icons.add),
                  )
                : TextField(
                    controller: controller,
                    onChanged: onChange,
                    onTap: onTap,
                    readOnly: isReadOnly || onTap != null,
                    keyboardType: keyboardType,
                    inputFormatters: [
                      if (keyboardType == TextInputType.number && !allowBlanks)
                        FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle:
                          const TextStyle(fontSize: 18, color: Colors.black38),
                      border: InputBorder.none,
                    ),
                  ),
          ),
          if (content != null)
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(infoTitle!),
                              content: content,
                              actions: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 10, right: 20),
                                    child: Text("Ok"),
                                  ),
                                )
                              ],
                            ));
                  },
                  child: const Icon(Icons.info)),
            ),
        ],
      ),
    );
  }
}
