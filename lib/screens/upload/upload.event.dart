import 'package:meta/meta.dart';

abstract class UploadEvent {}

class UploadButtonPressed extends UploadEvent {
  final String name;
  final String email;
  final String birthday;
  final String password;
  final String cPassword;

  UploadButtonPressed({
    @required this.name,
    @required this.email,
    @required this.birthday,
    @required this.password,
    @required this.cPassword,
  });
}