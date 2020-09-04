import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

import 'package:movieguide/domain/error/failure.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
