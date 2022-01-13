import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:ivse1_gymlife/feature/login/recources/api.dart';
import 'package:ivse1_gymlife/feature/login/recources/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RealApi implements Api {
  // Create device storage
  final storage = new FlutterSecureStorage();
  static const String URL = "http://10.0.2.2:6060/auth";

  @override
  Future<LoginResponse> login(String username, String password) async {
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

      late final LoginResponse loginResponse;

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.toString());

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
  Future<LoginResponse> loginWithToken(String token) {
    // TODO: implement loginWithToken
    throw UnimplementedError();
  }

  @override
  forgotPassword(String username) async {
    try {
      final response = await http
          .post(Uri.parse('$URL/forgotPassword'), body: {"email": username});

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}
  }

  @override
  Future<LoginResponse> register(String username, String password, String email,
      String firstname, String lastname, String prefix) async {
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
  Future<LoginResponse> resetPassword(String password) async {
    try {
      final response = await http
          .post(Uri.parse('$URL/forgotPassword'), body: {"password": password});

      late final LoginResponse loginResponse;

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.toString());

        loginResponse = new LoginResponse(
            jsonResponse['accessToken'], jsonResponse['refreshToken']);

        // store token
        storage.write(key: "Bearer", value: loginResponse.accessToken);

        return loginResponse;
      } else {
        return LoginResponse("", "");
      }
    } catch (e) {
      return LoginResponse("", "");
    }
  }
}

class LoggerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("----- Request -----");
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("----- Response -----");
    print(data.toString());
    return data;
  }
}
