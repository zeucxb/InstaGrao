import 'package:meta/meta.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String name;
  final String email;
  final String birthday;
  final String password;
  final String cPassword;

  LoginButtonPressed({
    @required this.name,
    @required this.email,
    @required this.birthday,
    @required this.password,
    @required this.cPassword,
  });
}