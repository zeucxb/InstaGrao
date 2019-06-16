import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.6,
          child: ModalBarrier(
            dismissible: false,
            color: Colors.white,
          ),
        ),
        Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink),
          ),
        ),
      ],
    );
  }
}
