import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:instagrao/helpers/error.helper.dart';

import 'package:instagrao/screens/register/register.event.dart';
import 'package:instagrao/screens/register/register.state.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ScreenBloc screenBloc;

  RegisterBloc(this.screenBloc);

  RegisterState get initialState => RegisterState.initial();

  void onRegisterButtonPressed({
    String name,
    String email,
    String birthday,
    String password,
    String cPassword,
  }) {
    dispatch(RegisterButtonPressed(
      name: name,
      email: email,
      birthday: birthday,
      password: password,
      cPassword: cPassword,
    ));
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      screenBloc.enableLoader();

      try {
        if (
          event.name.isEmpty
          || event.email.isEmpty
          || event.birthday.isEmpty
          || event.password.isEmpty
          || event.cPassword.isEmpty
        ) throw('Complete all required fields!');

        if (event.password != event.cPassword) throw('Invalid password confirmation!');

        // API Request code here.

        yield RegisterState.success();
      } catch (error) {
        if (error is String) {
          try {
            var validationError = json.decode(error)['validationError'];

            var errorMessage = ErrorHelper.formatValidationError(validationError);

            yield RegisterState.failure(errorMessage);
          } catch (e) {
            yield RegisterState.failure(error);
          }
        } else {
          yield RegisterState.failure(error.toString());
        }
      }

      screenBloc.disableLoader();
    }
  }
}
