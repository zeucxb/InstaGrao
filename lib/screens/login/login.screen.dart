import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagrao/helpers/validator.helper.dart';
import 'package:instagrao/screens/login/login.bloc.dart';
import 'package:instagrao/screens/login/login.event.dart';
import 'package:instagrao/screens/login/login.state.dart';
import 'package:instagrao/screens/main.screen.dart';
import 'package:instagrao/screens/register/register.screen.dart';
import 'package:instagrao/shared/root/root.bloc.dart';
import 'package:instagrao/shared/root/root.state.dart';
import 'package:instagrao/widgets/divider-with-text/divider-with-text.dart';
import 'package:instagrao/widgets/primary-button/primary-button.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';
import 'package:instagrao/widgets/screen/screen.widget.dart';
import 'package:instagrao/widgets/secondary-button/secondary-button.dart';
import 'package:instagrao/widgets/view/view.widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  RootBloc rootBloc;
  ScreenBloc screenBloc;
  LoginBloc loginBloc;
  String email, password;

  var _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    rootBloc = BlocProvider.of<RootBloc>(context);
    screenBloc = ScreenBloc();
    loginBloc = LoginBloc(context, screenBloc);

    return BlocListener(
      bloc: rootBloc,
      listener: (context, RootState state) {
        if (state.isLoggedIn) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(title: 'Home'),
              ),
            );
          });
        }
      },
      child: BlocBuilder<LoginEvent, LoginState>(
        bloc: loginBloc,
        builder: (
          BuildContext context,
          LoginState loginState,
        ) {
          return Screen(
            bloc: screenBloc,
            children: [
              View(
                title: 'Login',
                error: loginState.error,
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/instagrao-logo.png'),
                        height: 250,
                        width: 200,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email:'),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailCtrl,
                        validator: ValidatorHelper.validateEmail,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password:'),
                        controller: passwordCtrl,
                        validator: ValidatorHelper.notEmpty,
                      ),
                      PrimaryButton.widget(
                          context,
                          'Login',
                          loginState.isLoginButtonEnabled
                              ? _onLoginButtonPressed
                              : null),
                      DividerWithText.widget('or'),
                      SecondaryButton.widget(
                        context,
                        'Register',
                        _onRegisterButtonPressed,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _onRegisterButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }

  _onLoginButtonPressed() {
    if (_formKey.currentState.validate()) {
      loginBloc.onLoginButtonPressed(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
