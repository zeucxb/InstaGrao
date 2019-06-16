import 'package:flutter/material.dart';
import 'package:instagrao/widgets/error-handler/error-handler.widget.dart';
import 'package:instagrao/widgets/navigation-bar/navigation-bar.widget.dart';

class View extends StatelessWidget {
  View({
    Key key,
    @required this.title,
    @required this.child,
    this.error = '',
    this.enableDefaultPadding = true,
  }) : super(key: key);

  final String title;
  final String error;
  final Widget child;

  final bool enableDefaultPadding;

  @override
  Widget build(BuildContext context) {
    var defaultPadding = 0.0;
    if (this.enableDefaultPadding) defaultPadding = 20.0;

    return Scaffold(
      appBar: NavigationBar.widget(context, title),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: ErrorHandler(
          error: error,
          child: child,
        ),
      ),
    );
  }
}
