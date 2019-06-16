import 'package:meta/meta.dart';

class RegisterState {
  final bool isLoading;
  final bool isRegisterButtonEnabled;
  final String error;
  final bool success;

  const RegisterState({
    @required this.isLoading,
    @required this.isRegisterButtonEnabled,
    @required this.error,
    @required this.success,
  });

  factory RegisterState.initial() {
    return RegisterState(
      isLoading: false,
      isRegisterButtonEnabled: true,
      error: '',
      success: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isLoading: true,
      isRegisterButtonEnabled: false,
      error: '',
      success: false,
    );
  }

  factory RegisterState.failure(Object error) {
    return RegisterState(
      isLoading: false,
      isRegisterButtonEnabled: true,
      error: error,
      success: false,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isLoading: false,
      isRegisterButtonEnabled: true,
      error: '',
      success: true,
    );
  }
}