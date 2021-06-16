import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

import 'package:movieguide/domain/error/error_entity.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<ErrorEntity, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
