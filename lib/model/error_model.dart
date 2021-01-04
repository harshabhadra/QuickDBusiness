enum ErrorType { UNKNOWN, FIREBASE_AUTH }

class ErrorModel {
  ErrorType errorType;
  String errorMessage;
  String description;
  ErrorModel({
    this.errorType,
    this.errorMessage,
    this.description,
  });
}
