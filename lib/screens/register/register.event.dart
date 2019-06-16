import 'package:meta/meta.dart';

abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String name;
  final String email;
  final String birthday;
  final String password;
  final String cPassword;

  RegisterButtonPressed({
    @required this.name,
    @required this.email,
    @required this.birthday,
    @required this.password,
    @required this.cPassword,
  });
}