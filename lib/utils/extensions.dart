import 'dart:async';

import 'package:dartz/dartz.dart';

// Extension on Either<L, R>
extension EitherX<L, R> on Either<L, R> {
  Future<void> handle({
    required FutureOr<void> Function(R right) onRight,
    required FutureOr<void> Function(L left) onLeft,
  }) async {
    fold(onLeft, onRight);
  }
}

// Extension on Future<Either<L, R>>
extension FutureEitherX<L, R> on Future<Either<L, R>> {
  Future<void> handle({
    required FutureOr<void> Function(R right) onRight,
    required FutureOr<void> Function(L left) onLeft,
  }) async {
    final either = await this;
    await either.handle(onRight: onRight, onLeft: onLeft);
  }
}

