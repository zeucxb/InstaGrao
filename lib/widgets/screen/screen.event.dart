import 'package:meta/meta.dart';

abstract class ScreenEvent {}

class ScreenLoader extends ScreenEvent {
  final bool isLoading;

  ScreenLoader({@required this.isLoading});
}
