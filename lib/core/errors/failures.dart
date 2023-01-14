import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure({required this.message});
  @override
  List<Object?> get props => [];
}

class ServerError extends Failure {
  ServerError({required super.message});
}

class LocalDbError extends Failure {
  LocalDbError({required super.message});
}
