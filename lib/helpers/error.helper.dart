class ErrorHelper {
  static Map statusCodeMessages = {
    404: 'Not Found',
    401: 'Unauthorized',
  };

  static String formatValidationError(Map validationError) {
    var errorMessage = '';
    validationError.forEach(
        (key, value) => errorMessage += '"$key": ' + value.join(',') + '\n');
    return errorMessage;
  }

  static String formatStatusError(int statusCode) {
    var errorMessage = statusCodeMessages[statusCode];

    if (errorMessage == null) {
      return 'An error happened';
    }

    return errorMessage;
  }
}
