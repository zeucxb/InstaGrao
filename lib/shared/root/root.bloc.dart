import 'package:bloc/bloc.dart';

import 'package:instagrao/shared/root/root.event.dart';
import 'package:instagrao/shared/root/root.state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootState get initialState => RootState.initial();

  void login() {
    dispatch(RootAuth(
      isLoggedIn: true,
    ));
  }

  void logout() {
    dispatch(RootAuth(
      isLoggedIn: false,
    ));
  }

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    if (event is RootAuth) {
      if (event.isLoggedIn) {
        yield RootState.loggedIn();
      } else {
        yield RootState.notLoggedIn();
      }
    }
  }
}
