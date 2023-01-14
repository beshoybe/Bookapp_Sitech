import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super("Error During Communication");
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super("Bad Request");
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super("Unauthorized");
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super("Requested Info Not Found");
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super("Conflict Occurred");
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message])
      : super("Internal Server Error");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message])
      : super("No Internet Connection");
}

class LocalDbException extends Equatable implements Exception {
  final String? message;

  const LocalDbException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class DataBaseClosedException extends LocalDbException {
  const DataBaseClosedException([message]) : super("Database Closed");
}

class DuplicateColumnException extends LocalDbException {
  const DuplicateColumnException([message]) : super("Entery Already Exists");
}

class TableNotFoundException extends LocalDbException {
  const TableNotFoundException([message]) : super("Table Not Found");
}

class NoDataFoundException extends LocalDbException {
  const NoDataFoundException([message]) : super("No Data Found");
}
