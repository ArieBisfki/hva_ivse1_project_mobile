import 'dart:convert';

import 'package:ivse1_gymlife/feature/login/recources/api.dart';
import 'package:ivse1_gymlife/feature/login/recources/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RealApi implements Api {
  // Create storage
  final storage = new FlutterSecureStorage();
  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await http.post(
          Uri.parse('http://10.0.2.2:6060/auth/login'),
          body: {"email": username, "password": password});

      late final LoginResponse loginResponse;

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        loginResponse = new LoginResponse(
            jsonResponse['accessToken'], jsonResponse['refreshToken']);

        // store token
        storage.write(key: "Bearer", value: loginResponse.accessToken);

        return loginResponse;
      } else {
        //loginResponse = null; // TODO
        return LoginResponse("", "");
      }
    } catch (e) {
      return LoginResponse(e, e); // TODO
    }
  }

  @override
  forgotPassword(String username) {
    // TODO: implement forgotPassword
  }

  @override
  Future<LoginResponse> register(String username, String password,
      profilePicture, String firstname, String lastname, String prefix) async {
    try {
      final response = await http
          .post(Uri.parse('http://10.0.2.2:6060/auth/register'), body: {
        "email": username,
        "password": password,
        "profilePicture": profilePicture,
        "firstName": firstname,
        "lastName": lastname,
        "prefix": prefix
      });

      late final LoginResponse loginResponse;

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        loginResponse = new LoginResponse(
            jsonResponse['accessToken'], jsonResponse['refreshToken']);

        // store token
        storage.write(key: "Bearer", value: loginResponse.accessToken);

        return loginResponse;
      } else {
        return LoginResponse("", "");
      }
    } catch (e) {
      return LoginResponse("", e);
    }
  }

  @override
  Future<LoginResponse> resetPassword(String password) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
