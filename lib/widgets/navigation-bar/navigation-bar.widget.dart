import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagrao/shared/root/root.bloc.dart';
import 'package:instagrao/screens/login/login.screen.dart';
import 'package:instagrao/helpers/theme.helper.dart';

class NavigationBar {
  NavigationBar({this.showLogout = false});

  final bool showLogout;

  void _logout(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);

    rootBloc.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  PreferredSizeWidget widget(BuildContext context, String title) {
    final primaryColor = ThemeHelper.of(context).primaryColor;

    if (Platform.isIOS)
      return CupertinoNavigationBar(
        actionsForegroundColor: primaryColor,
        padding: EdgeInsetsDirectional.only(top: 5, start: 10),
        middle: DefaultTextStyle(
          child: Text(title),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontSize: 20,
          ),
        ),
        trailing: showLogout
            ? IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _logout(context);
                },
              )
            : null,
      );
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        showLogout
            ? IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {},
              )
            : null,
      ],
    );
  }
}
