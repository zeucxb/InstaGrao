import 'package:meta/meta.dart';

abstract class RootEvent {}

class RootAuth extends RootEvent {
  final bool isLoggedIn;

  RootAuth({@required this.isLoggedIn});
}
