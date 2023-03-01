import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Function? onPressed;
  final double width;
  final double height;
  final Color? btnColor;
  final bool disabled;
  final double textSize;
  final double borderRadius;
  final bool containerBoarder;

  static Color PrimaryColorVariant = Color(0xFF1565C0);

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.width,
    this.disabled = false,
    this.btnColor,
    this.textSize = 24.0,
    this.borderRadius = 10.0,
    this.height = 60.0,
    this.containerBoarder = false,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          if (!disabled && onPressed != null) onPressed!();
        },
        child: Container(
          decoration: BoxDecoration(
            border: containerBoarder != false ? Border.all(width: 1, color: Colors.blue) : null,
            borderRadius: BorderRadius.circular(borderRadius),
            color: disabled
                ? Colors.grey
                : btnColor == null
                ? Colors.blue
                : btnColor,
          ),
          height: height,
          width: width,

          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: textSize, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
