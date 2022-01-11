import 'package:ivse1_gymlife/feature/login/recources/login_response.dart';

abstract class Api {
  Future<LoginResponse> login(String username, String password) async {
    return LoginResponse("", "");
  }

  Future<LoginResponse> register(String username, String password,
      profilePicture, String firstname, String lastname, String prefix) async {
    return LoginResponse("", "");
  }

  forgotPassword(String username) async {
    return LoginResponse("", "");
  }

  Future<LoginResponse> resetPassword(String password) async {
    return LoginResponse("", "");
  }
}
