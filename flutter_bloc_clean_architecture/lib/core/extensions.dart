import 'package:dartz/dartz.dart';

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Exception, U>> mapLeftToException() {
    return map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Exception;
        } catch (e) {
          // ignore: only_throw_errors
          throw obj;
        }
      }),
    );
  }
}
