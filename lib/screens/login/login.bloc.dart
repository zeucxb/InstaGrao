import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';

import 'package:instagrao/screens/login/login.event.dart';
import 'package:instagrao/screens/login/login.state.dart';
import 'package:instagrao/shared/root/root.bloc.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BuildContext context;
  final ScreenBloc screenBloc;
  RootBloc rootBloc;

  LoginBloc(this.context, this.screenBloc) {
    rootBloc = BlocProvider.of<RootBloc>(context);
  }

  LoginState get initialState => LoginState.initial();

  void onLoginButtonPressed({
    String name,
    String email,
    String birthday,
    String password,
    String cPassword,
  }) {
    dispatch(LoginButtonPressed(
      name: name,
      email: email,
      birthday: birthday,
      password: password,
      cPassword: cPassword,
    ));
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      screenBloc.enableLoader();

      try {
        if (
          event.email.isEmpty
          || event.password.isEmpty
        ) throw('Complete all required fields!');

        // API Resquest code.

        rootBloc.login();
        yield LoginState.success('JWTtoken');
      } catch (error) {
        yield LoginState.failure(error.toString());
      }

      screenBloc.disableLoader();
    }
  }
}
