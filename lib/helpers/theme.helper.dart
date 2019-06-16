import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  static of(BuildContext context) {
    if (Platform.isIOS) return CupertinoTheme.of(context);
    return Theme.of(context);
  }

  static ThemeData getThemeData() {
    final primaryColor = Colors.purple;

    return ThemeData(
      primaryColor: primaryColor,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: primaryColor,
      ),
    );
  }
}
