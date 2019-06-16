import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagrao/helpers/theme.helper.dart';
import 'package:instagrao/screens/login/login.screen.dart';
import 'package:instagrao/shared/root/root.bloc.dart';
import 'package:instagrao/widgets/app/app.widget.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  final rootBloc = RootBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RootBloc>(
      bloc: rootBloc,
      child: App(
        title: 'InstaGrão',
        theme: ThemeHelper.getThemeData(),
        home: LoginScreen(),
      ),
    );
  }
}
