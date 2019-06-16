import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget {
  const ErrorHandler({
    @required this.error,
    @required this.child,
  });

  final String error;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final snackBar = SnackBar(
      content: Text(this.error),
      duration: Duration(seconds: 30),
      backgroundColor: Colors.red,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (this.error != '') {
        scaffold.showSnackBar(snackBar);
      } else {
        scaffold.hideCurrentSnackBar();
      }
    });

    return child;
  }
}