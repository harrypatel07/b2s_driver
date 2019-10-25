import 'package:flutter/material.dart';

class ThemePrimary {
  static const primaryColor = Color(0xFF007658);

  static const gradientColor = Color(0xFF0e9976);

  static const primaryFontFamily = "Quicksand";

  static const appBar_textTheme = TextTheme(
    title: TextStyle(
        fontFamily: primaryFontFamily,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold),
  );
  static const appBar_iconTheme = IconThemeData(
    color: Colors.white,
  );

  static const Color gradientStart = primaryColor;
  static const Color gradientEnd = gradientColor;

  static const primaryGradient = LinearGradient(
    colors: const [gradientStart, gradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const chatBubbleGradient = const LinearGradient(
    colors: const [Color(0xFFf7e572), Color(0xFFFF8961)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const chatBubbleGradient2 = const LinearGradient(
    colors: const [Color(0xFFf0edda), Color(0xFFf0edda)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  static theme() {
    return ThemeData(
        fontFamily: primaryFontFamily,
        primaryColor: primaryColor,
        //primaryColor: Colors.blue,
        backgroundColor: Colors.white,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.blue,
          actionTextColor: Colors.white,
        )
        //canvasColor: Colors.white,
        // appBarTheme: AppBarTheme(
        //     textTheme: appBar_textTheme, iconTheme: appBar_iconTheme),
        );
  }

  static TextStyle loginPageButton(BuildContext context) {
    return TextStyle(color: Theme.of(context).primaryColor, fontSize: 15);
  }

  static const history_page_backgroundcolor = Color(0XFFF3F7F6);
}
