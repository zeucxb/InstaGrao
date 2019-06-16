import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabs {
  static Widget widget(ValueChanged<int> onTap, int currentIndex,
      List<BottomNavigationBarItem> items) {
    if (Platform.isIOS)
      return CupertinoTabBar(
        onTap: onTap,
        currentIndex: currentIndex,
        items: items,
      );
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items: items,
    );
  }
}
