import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/exceptions.dart';

abstract class Usecase<Type, Params> {
  Future<Either<ServerException, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
