import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagrao/widgets/date-picker/date-picker.dart';
import 'package:instagrao/widgets/primary-button/primary-button.dart';
import 'package:instagrao/helpers/validator.helper.dart';

import 'package:instagrao/screens/upload/upload.bloc.dart';
import 'package:instagrao/screens/upload/upload.event.dart';
import 'package:instagrao/screens/upload/upload.state.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';
import 'package:instagrao/widgets/screen/screen.widget.dart';
import 'package:instagrao/widgets/view/view.widget.dart';

class UploadScreen extends StatefulWidget {
  @override
  State<UploadScreen> createState() => _UploadScreen();
}

class _UploadScreen extends State<UploadScreen> {
  ScreenBloc screenBloc;
  UploadBloc uploadBloc;

  var _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final cPasswordCtrl = TextEditingController();
  var birthday = DateTime(DateTime.now().year - 18);

  _onDatePickerChanged(DateTime newDateTime) {
    setState(
      () => birthday = newDateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    screenBloc = ScreenBloc();
    uploadBloc = UploadBloc(screenBloc);

    return BlocBuilder<UploadEvent, UploadState>(
      bloc: uploadBloc,
      builder: (
        BuildContext context,
        UploadState uploadState,
      ) {
        if (uploadState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(
              context,
            );
          });
        }

        return Screen(
          bloc: screenBloc,
          children: [
            View(
              title: 'Upload',
              error: uploadState.error,
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name:'),
                      controller: nameCtrl,
                      validator: ValidatorHelper.notEmpty,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email:'),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailCtrl,
                      validator: ValidatorHelper.validateEmail,
                    ),
                    DatePicker().widget(context, 'Birthday:', birthday, _onDatePickerChanged),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password:'),
                      controller: passwordCtrl,
                      obscureText: true,
                      validator: ValidatorHelper.notEmpty,
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Confirm Password:'),
                      controller: cPasswordCtrl,
                      obscureText: true,
                      validator: ValidatorHelper.notEmpty,
                    ),
                    PrimaryButton.widget(
                      context,
                      'Upload',
                      uploadState.isUploadButtonEnabled
                          ? _onUploadButtonPressed
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _onUploadButtonPressed() {
    if (_formKey.currentState.validate()) {
      uploadBloc.onUploadButtonPressed(
        name: nameCtrl.text,
        email: emailCtrl.text,
        birthday: birthday.toString(),
        password: passwordCtrl.text,
        cPassword: cPasswordCtrl.text,
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  void dispose() {
    uploadBloc.dispose();
    super.dispose();
  }
}
