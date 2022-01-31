import 'package:either_dart/either.dart';
import 'package:ivse1_gymlife/feature/login/models/login_creds_response_E.dart';
import 'package:ivse1_gymlife/feature/login/models/login_response_S.dart';

abstract class Api {
  Future<Either<LoginCredsResponseE, LoginResponseS>> login(
      String username, String password) async {
    return Future.value(); // TODO
  }

  Future<Either<LoginCredsResponseE, LoginResponseS>>
      loginWithRefreshToken() async {
    return Future.value(); // TODO
  }

  Future<Either<LoginCredsResponseE, LoginResponseS>> register(
      String username,
      String password,
      String email,
      String firstname,
      String lastname,
      String prefix) async {
    return Future.value(); // TODO
  }

  forgotPassword(String username) async {}
}
