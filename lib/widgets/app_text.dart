import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final bool bold;
  final Color? color;
  final bool justifyText;
  final bool alignText;
  final bool underline;
  final bool  ellipsis;
  final Function()? onTap;

  const AppText(
    this.text, {
    Key? key,
    this.size = 18,
    this.bold = false,
    this.color = Colors.black,
    this.justifyText = false,
    this.alignText = false,
    this.onTap,
    this.underline = false, this.ellipsis = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? onTap : null,
      child: Text(
        text,
        textAlign: justifyText
            ? TextAlign.justify
            : alignText
                ? TextAlign.center
                : null,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          overflow: ellipsis ? TextOverflow.ellipsis : null,
          color: color,
          fontSize: size,
          decoration: underline ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}

class AppBarText extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const AppBarText({Key? key, required this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? onTap : null,
      child: Container(
        child: AppText(
          text,
          color: Colors.white,
          size: 12,
          alignText: true,
        ),
      ),
    );
  }
}

class AppTextWithInfoIcon extends StatelessWidget {
  final String text;
  final double size;
  final bool bold;
  final Color color;
  final Widget infoIcon;

  const AppTextWithInfoIcon(
    this.text, {
    Key? key,
    this.size = 18,
    this.bold = false,
    required this.color,
    required this.infoIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: text,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: color,
              fontSize: size,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: infoIcon,
            ),
          ),
        ],
      ),
    );
  }
}

class RequiredText extends StatelessWidget {
  final String labelText;
  final String requiredSign;
  final double labelTextScale;
  final int labelMaxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color labelColor;

//  final FontWeight fontWeight;
  final double fontSize;

  const RequiredText(
    this.labelText, {
    Key? key,
    this.requiredSign = ' *',
    this.labelColor = Colors.black54,
    // this.fontWeight,
    required this.fontSize,
    this.labelMaxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.labelTextScale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: RichText(
        text: TextSpan(
            text: labelText,
            style: TextStyle(
              color: labelColor,
              fontSize: fontSize,
            ),
            children: [
              TextSpan(
                  text: requiredSign,
                  style: TextStyle(
                      color: Colors.red,
                      //  fontWeight: fontWeight,
                      fontSize: fontSize))
            ]),
        textScaleFactor: labelTextScale,
        maxLines: labelMaxLines,
        overflow: overflow,
        textAlign: textAlign,
      ),
    );
  }
}
