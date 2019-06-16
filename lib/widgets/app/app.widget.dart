import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({Key key, this.title, this.theme, this.home}) : super(key: key);

  final String title;
  final ThemeData theme;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) return CupertinoApp(title: title, home: home, theme: MaterialBasedCupertinoThemeData(materialTheme: theme));
    return MaterialApp(title: title, theme: theme, home: home);
  }
}
