import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:ivse1_gymlife/common/util/logger_interceptor.dart';
import 'package:ivse1_gymlife/feature/login/models/login_creds_response_E.dart';
import 'package:ivse1_gymlife/feature/login/recources/api.dart';
import 'package:ivse1_gymlife/feature/login/models/login_response_S.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginApi implements Api {
  // Create device storage
  final storage = new FlutterSecureStorage();
  static const String URL = "http://10.0.2.2:6060/auth";

  responseIsError(Either<LoginCredsResponseE, LoginResponseS> response) {
    return response.isLeft;
  }

  @override
  Future<Either<LoginCredsResponseE, LoginResponseS>> login(
      String username, String password) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()])
              .post(Uri.parse('$URL/login'),
                  headers: requestHeaders,
                  body: jsonEncode({
                    "username": username,
                    "password": password,
                  }));

      switch (response.statusCode) {
        case 200:
          final loginResponse = LoginResponseS("", "", "", "");
          var jsonResponse = jsonDecode(response.body);

          loginResponse.accessToken = jsonResponse['accessToken'];
          loginResponse.refreshToken = jsonResponse['refreshToken'];
          // loginResponse.accessTokenExpiresIn =
          //     jsonResponse['accessTokenExpiresIn'];
          // loginResponse.refreshTokenExpiresIn =
          //     jsonResponse['refreshTokenExpiresIn'];

          // TODO update backend to add expire dates

          // store token
          storage.write(
            key: "accessToken",
            value: loginResponse.accessToken,
          );
          storage.write(
            key: "refreshToken",
            value: loginResponse.refreshToken,
          );
          // storage.write(
          //   key: "accessTokenExpiresIn",
          //   value: loginResponse.accessTokenExpiresIn,
          // );
          // storage.write(
          //   key: "refreshTokenExpiresIn",
          //   value: loginResponse.refreshTokenExpiresIn,
          // );
          return Right(loginResponse);
        case 401:
          return Left(LoginCredsResponseE.INVALID_CREDENTIALS);
        case 500:
          return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
        default:
          return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
      }
    } catch (e) {
      return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  loginWithRefreshToken() async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      String? refreshToken = await storage.read(key: 'refreshToken');
      if (refreshToken == null) {
        return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
      }
      print(refreshToken.toString());

// TODO code 500
      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()])
              .post(Uri.parse('$URL/login'),
                  headers: requestHeaders,
                  body: jsonEncode({
                    "refreshToken": refreshToken.toString(),
                  }));

      switch (response.statusCode) {
        case 200:
          final loginResponse = LoginResponseS("", "", "", "");
          var jsonResponse = jsonDecode(response.body);

          loginResponse.accessToken = jsonResponse['accessToken'];
          loginResponse.refreshToken = jsonResponse['refreshToken'];
          // loginResponse.accessTokenExpiresIn =
          //     jsonResponse['accessTokenExpiresIn'];
          // loginResponse.refreshTokenExpiresIn =
          //     jsonResponse['refreshTokenExpiresIn'];

          // store token
          storage.write(key: "accessToken", value: loginResponse.accessToken);
          storage.write(key: "refreshToken", value: loginResponse.refreshToken);
          // storage.write(
          //     key: "accessTokenExpiresIn",
          //     value: loginResponse.accessTokenExpiresIn);
          // storage.write(
          //     key: "refreshTokenExpiresIn",
          //     value: loginResponse.refreshTokenExpiresIn);
          return Right(loginResponse);
        case 401:
          return Left(LoginCredsResponseE.INVALID_CREDENTIALS);
        case 500:
          return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
        default:
          return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
      }
    } catch (e) {
      return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  forgotPassword(String email) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()]).post(
              Uri.parse('$URL/forgotPassword'),
              headers: requestHeaders,
              body: {"email": email});

      switch (response.statusCode) {
        case 200:
          return;
        case 401:
          return Left(LoginCredsResponseE.INVALID_CREDENTIALS);
        case 500:
          return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
        default:
          return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
      }
    } catch (e) {
      return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<Either<LoginCredsResponseE, LoginResponseS>> register(
      String username,
      String password,
      String email,
      String firstname,
      String lastname,
      String prefix) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()])
              .post(Uri.parse('$URL/register'),
                  headers: requestHeaders,
                  body: jsonEncode({
                    "username": username,
                    "password": password,
                    "email": email,
                    "firstName": firstname,
                    "lastName": lastname,
                    "prefix": prefix
                  }));

      switch (response.statusCode) {
        case 200:
          final loginResponse = LoginResponseS("", "", "", "");
          var jsonResponse = jsonDecode(response.body);

          loginResponse.accessToken = jsonResponse['accessToken'];
          loginResponse.refreshToken = jsonResponse['refreshToken'];
          loginResponse.accessTokenExpiresIn = jsonResponse['refreshToken'];
          loginResponse.refreshTokenExpiresIn = jsonResponse['refreshToken'];

          // store token
          storage.write(key: "accesstoken", value: loginResponse.accessToken);
          storage.write(key: "refreshtoken", value: loginResponse.refreshToken);
          storage.write(
              key: "refreshtoken", value: loginResponse.accessTokenExpiresIn);
          storage.write(
              key: "refreshtoken", value: loginResponse.refreshTokenExpiresIn);
          return Right(loginResponse);
        case 401:
          return Left(LoginCredsResponseE.INVALID_CREDENTIALS);
        case 500:
          return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
        default:
          return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
      }
    } catch (e) {
      return Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR);
    }
  }
}
