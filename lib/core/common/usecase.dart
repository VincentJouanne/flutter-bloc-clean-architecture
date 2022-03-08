import 'package:dartz/dartz.dart';

abstract class UseCase<T, P> {
  Future<Either<Exception, T>> call({required P params});
}
