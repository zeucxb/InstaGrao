import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagrao/helpers/theme.helper.dart';

class PrimaryButton {
  static Widget widget(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          child: Text(
            text,
            textScaleFactor: 1.5,
          ),
          color: ThemeHelper.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
