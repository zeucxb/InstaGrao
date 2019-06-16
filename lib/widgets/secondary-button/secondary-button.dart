import 'package:flutter/material.dart';
import 'package:instagrao/helpers/theme.helper.dart';

class SecondaryButton {
  static Widget widget(BuildContext context, String text, VoidCallback onPressed) {
    final primaryColor = ThemeHelper.of(context).primaryColor;
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: SizedBox(
        width: double.infinity,
        child: OutlineButton(
          borderSide: BorderSide(color: primaryColor),
          padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          child: Text(
            text,
            textScaleFactor: 1.5,
          ),
          textColor: primaryColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
