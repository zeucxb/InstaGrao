import 'package:bloc/bloc.dart';

import 'package:instagrao/widgets/screen/screen.event.dart';
import 'package:instagrao/widgets/screen/screen.state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenState get initialState => ScreenState.initial();

  void enableLoader() {
    dispatch(ScreenLoader(
      isLoading: true,
    ));
  }

  void disableLoader() {
    dispatch(ScreenLoader(
      isLoading: false,
    ));
  }

  @override
  Stream<ScreenState> mapEventToState(ScreenEvent event) async* {
    if (event is ScreenLoader) {
      if (event.isLoading) {
        yield ScreenState.loading();
      } else {
        yield ScreenState.notLoading();
      }
    }
  }
}
