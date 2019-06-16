import 'package:meta/meta.dart';

class ScreenState {
  final bool isLoading;
  final String error;
  final String result;

  const ScreenState({
    @required this.isLoading,
    @required this.error,
    @required this.result,
  });

  factory ScreenState.initial() {
    return ScreenState.notLoading();
  }

  factory ScreenState.notLoading() {
    return ScreenState(
      isLoading: false,
      error: '',
      result: '',
    );
  }

  factory ScreenState.loading() {
    return ScreenState(
      isLoading: true,
      error: '',
      result: '',
    );
  }

  factory ScreenState.failure(String error) {
    return ScreenState(
      isLoading: false,
      error: error,
      result: '',
    );
  }

  factory ScreenState.success(String result) {
    return ScreenState(
      isLoading: false,
      error: '',
      result: result,
    );
  }
}
