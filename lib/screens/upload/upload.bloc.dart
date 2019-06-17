import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:instagrao/helpers/error.helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:instagrao/screens/upload/upload.event.dart';
import 'package:instagrao/screens/upload/upload.state.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final ScreenBloc screenBloc;

  UploadBloc(this.screenBloc);

  UploadState get initialState => UploadState.initial();

  void onUploadButtonPressed({
    String name,
    String email,
    String birthday,
    String password,
    String cPassword,
  }) {
    dispatch(UploadButtonPressed(
      name: name,
      email: email,
      birthday: birthday,
      password: password,
      cPassword: cPassword,
    ));
  }

  @override
  Stream<UploadState> mapEventToState(UploadEvent event) async* {
    if (event is UploadButtonPressed) {
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

        fakeUpload(event.email, event.password, event.email);

        yield UploadState.success();
      } catch (error) {
        if (error is String) {
          try {
            var validationError = json.decode(error)['validationError'];

            var errorMessage = ErrorHelper.formatValidationError(validationError);

            yield UploadState.failure(errorMessage);
          } catch (e) {
            yield UploadState.failure(error);
          }
        } else {
          yield UploadState.failure(error.toString());
        }
      }

      screenBloc.disableLoader();
    }
  }

  void fakeUpload(String email, String password, String name) async {
    final storage = new FlutterSecureStorage();

    await storage.write(key: '$email-$password', value: name);
  }
}
