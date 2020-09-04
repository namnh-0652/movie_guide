import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure() : super();

  @override
  List<Object> get props => [];
}

class NetworkFailure extends Failure {}

class ServerFailure extends Failure {}

class CacheFailue extends Failure {}
