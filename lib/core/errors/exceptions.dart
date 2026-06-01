/// Base class for internal exceptions that will be caught
/// by repositories and mapped to [Failure] objects.
abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, {this.stackTrace});
}

class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.stackTrace});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.stackTrace});
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.stackTrace});
}

class PermissionException extends AppException {
  const PermissionException(super.message, {super.stackTrace});
}

class ExportException extends AppException {
  const ExportException(super.message, {super.stackTrace});
}

class ImportException extends AppException {
  const ImportException(super.message, {super.stackTrace});
}
