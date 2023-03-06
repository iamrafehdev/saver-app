import 'package:flutter/material.dart';
import 'package:saver/Utils/app_theme.dart';
import 'package:saver/widgets/app_container.dart';
import 'package:saver/widgets/app_text.dart';
import 'package:saver/widgets/sized_boxes.dart';


class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final double textWidth;

  const TextIcon({Key? key, required this.text, required this.icon, this.textWidth = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppContainer(
          width: 40,
          height: 40,
          borderRadius: 8,
          color: Colors.blueGrey.withOpacity(0.08),
          child: Icon(icon, color: AppTheme.PrimaryColor, size: 32),
        ),
        SizeBoxHeight4(),
        Container(
             width: textWidth,
            child: AppText(text, color: AppTheme.PrimaryColor, size: 16, alignText: true,))
      ],
    );
  }
}

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const AppIcon({
    Key? key,
    required this.icon,
     this.size = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppContainer(
          width: 40,
          height: 40,
          borderRadius: 8,
          color: Colors.blueGrey.withOpacity(0.08),
          child: Icon(icon, color: AppTheme.PrimaryColor, size: size,),
        ),
      ],
    );
  }
}
