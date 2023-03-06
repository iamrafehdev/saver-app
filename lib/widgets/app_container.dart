import 'package:flutter/material.dart';
import 'package:saver/Utils/app_theme.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double borderRadius;
  final double spreadRadius;
  final double blurRadius;
  final double borderWidth;
  final Color color;
  final Function()? onTap;
  final bool isShadow;

  const AppContainer({
    Key? key,
    required this.child,
    this.height = 50,
    this.width = 50,
    this.borderRadius = 0,
    required this.color,
    this.onTap,
    this.isShadow = false,
     this.spreadRadius = 5,
     this.blurRadius = 7,  this.borderWidth = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? onTap : null,
      child: Container(
        width: width,
        height: height,
        child: child,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderWidth == 0 ?  null : Border.all(color: AppTheme.PrimaryColor, width: borderWidth),
            boxShadow: isShadow
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: spreadRadius,
                      blurRadius: blurRadius,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ]
                : null),
      ),
    );
  }
}
