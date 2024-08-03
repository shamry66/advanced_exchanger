class FailureException implements Exception {
  final String message;

  FailureException(this.message);
}

class ServerException implements FailureException {
  @override
  final String message;

  ServerException(this.message);
}

class NetworkException implements FailureException {
  @override
  final String message;

  NetworkException(this.message);
}

class UserNotFoundException implements FailureException {
  @override
  final String message = "User not found!";
}

class RequestException implements FailureException {
  @override
  final String message;

  RequestException(this.message);
}
class ProcessingFailedException extends FailureException {
  ProcessingFailedException(super.message);
}

class TokenExpiredException extends FailureException {
  TokenExpiredException(super.message);
}

class InternetConnectionException extends FailureException {
  InternetConnectionException(super.message);
}

class TimeoutConnectionException extends FailureException {
  TimeoutConnectionException(super.message);
}
class NotFoundException extends FailureException {
  NotFoundException(super.message);
}

class UnAuthorizedException extends FailureException {
  UnAuthorizedException(super.message);
}

class AccountDeactivatedException extends FailureException {
  AccountDeactivatedException(super.message);
}