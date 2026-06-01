import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
/// A failure represents an error that has been caught and mapped
/// to a domain-level error with a user-friendly message.
abstract class Failure extends Equatable {
  final String message;
  final StackTrace? stackTrace;

  const Failure(this.message, {this.stackTrace});

  @override
  List<Object?> get props => [message, stackTrace];
}

/// Failure caused by database operations (SQLite errors, migration failures, etc.)
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.stackTrace});
}

/// Failure caused by invalid input or business rule violations.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.stackTrace});
}

/// Failure when a requested entity is not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.stackTrace});
}

/// Failure caused by missing permissions (notifications, storage, etc.)
class PermissionFailure extends Failure {
  const PermissionFailure(super.message, {super.stackTrace});
}

/// Failure during export or backup operations.
class ExportFailure extends Failure {
  const ExportFailure(super.message, {super.stackTrace});
}

/// Failure during import or restore operations.
class ImportFailure extends Failure {
  const ImportFailure(super.message, {super.stackTrace});
}

/// Failure caused by an unexpected or unknown error.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.stackTrace});
}
