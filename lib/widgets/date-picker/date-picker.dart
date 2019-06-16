import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker {
  DateTime currentDateTime = DateTime.now();

  Future _chooseDate(BuildContext context, DateTime initialDate, Function onChanged) async {
    var result = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (result == null) return;

    this.currentDateTime = result;

    onChanged(result);
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(List<Widget> children) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black54),
        ),
      ),
      height: 60.0,
      child: SafeArea(
        top: false,
        bottom: false,
        child: DefaultTextStyle(
          style: const TextStyle(
            letterSpacing: -0.24,
            fontSize: 17.0,
            color: Colors.black54,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget widget(BuildContext context, String label, DateTime initialDateTime, Function onChanged) {
    this.currentDateTime = initialDateTime;

    return GestureDetector(
      onTap: () {
        (Platform.isAndroid)
            ? _chooseDate(context, initialDateTime, onChanged)
            : showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) {
                  return _buildBottomPicker(
                    CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: initialDateTime,
                      onDateTimeChanged: (DateTime newDateTime) {
                        this.currentDateTime = newDateTime;

                        onChanged(newDateTime);
                      },
                    ),
                  );
                },
              );
      },
      child: _buildMenu(<Widget>[
        Text(label),
        Text(
          DateFormat.yMMMMd().format(this.currentDateTime),
          style: const TextStyle(color: CupertinoColors.inactiveGray),
        ),
      ]),
    );
  }
}
