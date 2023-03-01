import 'package:flutter/material.dart';

class AppLinearProgress extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final double height;
  final double value;
  final double screenWidth;

  const AppLinearProgress({
    Key? key,
    required this.backgroundColor,
    required this.color,
    required this.height,
    required this.value, this.screenWidth = 0.9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var progressWidth = MediaQuery.of(context).size.width * screenWidth;
    return Stack(
      children: [
        Container(
          width: progressWidth,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Container(
          width: progressWidth * (value / 100),
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
