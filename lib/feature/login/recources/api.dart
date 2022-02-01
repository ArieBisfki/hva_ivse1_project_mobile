import 'package:either_dart/either.dart';
import 'package:ivse1_gymlife/feature/login/models/login_creds_response_E.dart';
import 'package:ivse1_gymlife/feature/login/models/login_response_S.dart';

abstract class Api {
  Future<Either<LoginCredsResponseE, LoginResponseS>> login(
      String username, String password);

  Future<Either<LoginCredsResponseE, LoginResponseS>> loginWithRefreshToken();

  Future<Either<LoginCredsResponseE, LoginResponseS>> register(
      String username,
      String password,
      String email,
      String firstname,
      String lastname,
      String prefix);

  forgotPassword(String username) async {}
}
