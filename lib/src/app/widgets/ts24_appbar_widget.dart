import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class TS24AppBar extends GradientAppBar {
  TS24AppBar({
    Key key,
    Widget leading,
    bool automaticallyImplyLeading = true,
    Widget title,
    List<Widget> actions,
    Widget flexibleSpace,
    Widget bottom,
    double elevation = 4.0,
    Color backgroundColorStart = ThemePrimary.gradientColor,
    Color backgroundColorEnd = ThemePrimary.primaryColor,
    Brightness brightness,
    IconThemeData iconTheme = ThemePrimary.appBar_iconTheme,
    TextTheme textTheme = ThemePrimary.appBar_textTheme,
    bool primary = true,
    bool centerTitle,
    double titleSpacing = NavigationToolbar.kMiddleSpacing,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
  }) : super(
          key: key,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          backgroundColorStart: backgroundColorStart,
          backgroundColorEnd: backgroundColorEnd,
          brightness: brightness,
          iconTheme: iconTheme,
          textTheme: textTheme,
          primary: primary,
          centerTitle: centerTitle,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity,
          bottomOpacity: bottomOpacity,
        );
}
