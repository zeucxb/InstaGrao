import 'package:meta/meta.dart';

class UploadState {
  final bool isLoading;
  final bool isUploadButtonEnabled;
  final String error;
  final bool success;

  const UploadState({
    @required this.isLoading,
    @required this.isUploadButtonEnabled,
    @required this.error,
    @required this.success,
  });

  factory UploadState.initial() {
    return UploadState(
      isLoading: false,
      isUploadButtonEnabled: true,
      error: '',
      success: false,
    );
  }

  factory UploadState.loading() {
    return UploadState(
      isLoading: true,
      isUploadButtonEnabled: false,
      error: '',
      success: false,
    );
  }

  factory UploadState.failure(Object error) {
    return UploadState(
      isLoading: false,
      isUploadButtonEnabled: true,
      error: error,
      success: false,
    );
  }

  factory UploadState.success() {
    return UploadState(
      isLoading: false,
      isUploadButtonEnabled: true,
      error: '',
      success: true,
    );
  }
}