import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DividerWithText {
  static Widget widget(String text) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 10),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ),
        Text(text),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            width: 100,
            child: Divider(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
