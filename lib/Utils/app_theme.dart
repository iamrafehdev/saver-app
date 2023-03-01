import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();


  // static final Color PrimaryColor = Colors.blue;
  static final Color PrimaryColor = Colors.blue;
  // static Color PrimaryDarkColor = Color(0xFFFF7100);
  static Color PrimaryDarkColor = Color(0xffF58320);
  static Color UnreadChatBG = Color(0xffEE1D1D);
  static Color grayDark = Color(0xff616161);

  static final ThemeData AppThemeData = ThemeData(
    fontFamily: 'roboto',
    brightness: Brightness.light,
    primarySwatch: MaterialColor(0xff01508B, color),
    primaryColor: PrimaryColor,
    accentColor: PrimaryColor,
  );

  static Gradient Bluegradient = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[
    Color(0xFF90CAF9),
    Color(0xFF1565C0),
  ]);

  static final TextStyle heading2 = TextStyle(
    color: Color(0xff686795),
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static final TextStyle chatSenderName = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static final TextStyle bodyText1 = TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 1.2, fontWeight: FontWeight.w500);

  static final TextStyle bodyTextMessage = TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  static final TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}


Map<int, Color> color =
{
  50:Color.fromRGBO(4,131,184, .1),
  100:Color.fromRGBO(4,131,184, .2),
  200:Color.fromRGBO(4,131,184, .3),
  300:Color.fromRGBO(4,131,184, .4),
  400:Color.fromRGBO(4,131,184, .5),
  500:Color.fromRGBO(4,131,184, .6),
  600:Color.fromRGBO(4,131,184, .7),
  700:Color.fromRGBO(4,131,184, .8),
  800:Color.fromRGBO(4,131,184, .9),
  900:Color.fromRGBO(4,131,184, 1),
};

