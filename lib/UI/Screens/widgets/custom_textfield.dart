import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.focusNode,
    this.validator,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.checkEmptyString = true,
    this.shouldShowSearchBar = false,
    this.allowBlanks = true,
    this.maxLines = 1,
    this.dropdownValues,
    this.onValueSelect,
    this.onTap,
    this.onChange,
    this.color,
    this.typingTextColor,
  }) : super(key: key);
  final TextEditingController controller;
  final bool isPasswordField;
  final bool shouldShowSearchBar;
  final String hintText;
  final bool checkEmptyString;
  final bool allowBlanks;
  final FocusNode? focusNode;
  final Function()? onTap;
  final Function(String)? onValueSelect;
  final Function(String)? onChange;
  final int maxLines;
  final TextInputType keyboardType;
  final Widget? icon;
  final Color? color;
  final Color? typingTextColor;
  final List<String>? dropdownValues;
  String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  ///
  final FocusNode _focusNode = FocusNode();

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          key: _key,
          controller: widget.controller,
          focusNode: widget.focusNode ?? _focusNode,
          validator: widget.validator ??
              (val) {
                if (val != null) {
                  if (val.isEmpty && widget.checkEmptyString) {
                    return "Field cannot be submitted empty";
                  }
                }
                return null;
              },
          readOnly: widget.dropdownValues != null || widget.onTap != null,
          onChanged: widget.onChange,
          onTap: widget.onTap,
          obscureText: widget.isPasswordField,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.center,
          style: TextStyle(color: widget.typingTextColor ?? Colors.black),
          decoration: InputDecoration(
              // border: const OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.black, width: 1)),
              filled: true,
              focusColor: Colors.black,
              fillColor: Colors.white24,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.color ?? Colors.black26, width: 3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.color ?? Colors.black26, width: 3)),
              iconColor: Colors.black,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 3)),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color: widget.color ?? Colors.black26,
                  fontWeight: FontWeight.bold),
              // suffixIcon:,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.color ?? Colors.black45, width: 3))),
        ),
        if (widget.icon != null)
          Positioned(
            right: 5,
            top: 20,
            child: Container(
              width: 50,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 10, bottom: widget.maxLines != 1 ? 60 : 0),
                child:
                    Align(alignment: Alignment.centerLeft, child: widget.icon),
              ),
            ),
          )
      ],
    );
  }
}
