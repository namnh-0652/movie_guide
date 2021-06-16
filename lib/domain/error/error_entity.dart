import 'package:equatable/equatable.dart';

abstract class ErrorEntity extends Equatable implements Exception {
  final Exception? originalException;
  final int? errorCode;
  final String? errorMessage;
  ErrorEntity({this.originalException, this.errorCode, this.errorMessage});

  @override
  List<Object?> get props =>
      [this.originalException, this.errorCode, this.errorMessage];
}
