import 'package:meta/meta.dart';

class RootState {
  final bool isLoggedIn;

  const RootState({
    @required this.isLoggedIn,
  });

  factory RootState.initial() {
    return RootState.notLoggedIn();
  }

  factory RootState.notLoggedIn() {
    return RootState(
      isLoggedIn: false,
    );
  }

  factory RootState.loggedIn() {
    return RootState(
      isLoggedIn: true,
    );
  }
}
