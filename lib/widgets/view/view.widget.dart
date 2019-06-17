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
    this.enableScroll = true,
    this.floatingActionButton,
  }) : super(key: key);

  final String title;
  final String error;
  final Widget child;

  final bool enableDefaultPadding;
  final bool enableScroll;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    var defaultPadding = 0.0;
    if (this.enableDefaultPadding) defaultPadding = 20.0;

    final errorHandler = ErrorHandler(
      error: error,
      child: child,
    );

    return Scaffold(
      appBar: NavigationBar.widget(context, title),
      floatingActionButton: floatingActionButton,
      body: enableScroll
          ? SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              child: errorHandler,
            )
          : errorHandler,
    );
  }
}
