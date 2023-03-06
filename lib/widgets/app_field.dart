import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? onSaved;
  final String? initialValue;
  final String? label;
  final String? hint;
  final List<FilteringTextInputFormatter>? list;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final isEnable;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final bool decoration;
  final bool? showCursor;
  final bool obscureText;
  final bool autocorrect;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool maxLengthEnforced;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  AppField({
    Key? key,
    required this.controller,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.isEnable = true,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.decoration = true,
    this.label,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.list,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: TextFormField(
          key: key,
          controller: controller,
          initialValue: initialValue,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          // style: TextStyle(color: isEnable ? Colors.grey[500] : Colors.grey),
          style: TextStyle(color: Colors.black),
          textDirection: textDirection,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          autofocus: autofocus,
          onSaved: onSaved,
          readOnly: readOnly,
          showCursor: showCursor,
          obscureText: obscureText,
          autocorrect: autocorrect,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          onChanged: onChanged,
          onTap: onTap,
          inputFormatters: list,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          enabled: isEnable,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.blue,size: 20.0)
                : null,
            labelText: label,
            isDense: true,
            hintText: hint,
            fillColor: Colors.grey[800],
            border: InputBorder.none,
            labelStyle: TextStyle(
              color: isEnable ? Colors.grey[800] : Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }
}
