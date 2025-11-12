import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? userMessage;

  const Failure(this.message, {this.userMessage});

  String get displayMessage => userMessage ?? message;

  @override
  List<Object?> get props => [message, userMessage];
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(
    super.message, {
    super.userMessage,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, userMessage, statusCode];
}

class NetworkFailure extends Failure {
  final bool isNoInternet;

  const NetworkFailure(
    super.message, {
    super.userMessage,
    this.isNoInternet = false,
  });

  @override
  List<Object?> get props => [message, userMessage, isNoInternet];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.userMessage});
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.userMessage});
}
