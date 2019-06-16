import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagrao/helpers/theme.helper.dart';

class NavigationBar {
  static PreferredSizeWidget widget(BuildContext context, String title) {
    final primaryColor = ThemeHelper.of(context).primaryColor;
    if (Platform.isIOS)
      return CupertinoNavigationBar(
        actionsForegroundColor: primaryColor,
        padding: EdgeInsetsDirectional.only(top: 5, start: 10),
        middle: DefaultTextStyle(
          child: Text(title),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontSize: 20,
          ),
        ),
      );
    return AppBar(title: Text(title));
  }
}
