import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tots_flutter_test/core/helpers/dialog_helper.dart';
import 'package:dartz/dartz.dart';

// mostrar los modals según el error
class TryApiNetwork {
  static Future<Either<Failure, T>> call<T>({required Function() function}) async {
    try {
      // si está ok
      T result = await function();
      return Right(result);
    } on DefaultCustomError catch (e) {
      return Left(DefaultCustomFailure(e));
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } on SocketException catch (_) {
      return Left(SocketFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

// crear las excepcions
class DefaultCustomError implements Exception {
  DefaultCustomError(this.message, this.code);
  final String message;
  final int code;
}

class ServerException implements Exception {
  ServerException({this.message = 'Something goes wrong', this.code = 100});
  final String message;
  final int code;
}

// crear los modals
abstract class Failure {
  void showError({String? message, String? title, VoidCallback? callback});
}

class DefaultCustomFailure extends Failure {
  DefaultCustomFailure(this.error);
  final DefaultCustomError error;

  @override
  Future<void> showError({
    String? title,
    String? message,
    VoidCallback? callback,
  }) async {
    DialogHelper.showDefaultCustomError(
      title: 'ERROR ${error.code}',
      message: error.message,
    );
  }
}

class SocketFailure extends Failure {
  @override
  Future<void> showError({
    String? title,
    String? message,
    VoidCallback? callback,
  }) async {
    DialogHelper.showDefaultCustomError(
      title: 'Internet connection fail',
      message: 'connect your device to internet',
    );
  }
}

class ServerFailure extends Failure {
  @override
  Future<void> showError({
    String? message,
    String? title,
    VoidCallback? callback,
  }) async {
    DialogHelper.showDefaultCustomError(
      title: 'Something goes wron',
      message: 'Try again later',
    );
  }
}
