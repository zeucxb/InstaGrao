import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagrao/widgets/date-picker/date-picker.dart';
import 'package:instagrao/widgets/primary-button/primary-button.dart';
import 'package:instagrao/helpers/validator.helper.dart';

import 'package:instagrao/screens/register/register.bloc.dart';
import 'package:instagrao/screens/register/register.event.dart';
import 'package:instagrao/screens/register/register.state.dart';
import 'package:instagrao/shared/root/root.bloc.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';
import 'package:instagrao/widgets/screen/screen.widget.dart';
import 'package:instagrao/widgets/view/view.widget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  RootBloc rootBloc;
  ScreenBloc screenBloc;
  RegisterBloc registerBloc;

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
    rootBloc = BlocProvider.of<RootBloc>(context);
    screenBloc = ScreenBloc();
    registerBloc = RegisterBloc(screenBloc);

    return BlocBuilder<RegisterEvent, RegisterState>(
      bloc: registerBloc,
      builder: (
        BuildContext context,
        RegisterState registerState,
      ) {
        if (registerState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(
              context,
            );
          });

          rootBloc.login();
        }

        return Screen(
          bloc: screenBloc,
          children: [
            View(
              title: 'Register',
              error: registerState.error,
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
                      'Register',
                      registerState.isRegisterButtonEnabled
                          ? _onRegisterButtonPressed
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

  _onRegisterButtonPressed() {
    if (_formKey.currentState.validate()) {
      registerBloc.onRegisterButtonPressed(
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
    registerBloc.dispose();
    super.dispose();
  }
}
