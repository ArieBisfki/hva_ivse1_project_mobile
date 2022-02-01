import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ivse1_gymlife/common/route/routes.dart';
import 'package:ivse1_gymlife/common/widget/costum_textfield.dart';
import 'package:ivse1_gymlife/feature/calender/models/login_info.dart';
import 'package:ivse1_gymlife/feature/login/models/login_creds_response_E.dart';
import 'package:ivse1_gymlife/feature/login/models/login_response_S.dart';
import 'package:ivse1_gymlife/feature/login/recources/login_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Create storage
  final storage = new FlutterSecureStorage();
  final LoginApi api = new LoginApi();

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    //attemptRefreshTokenLogin();
  }

  attemptRefreshTokenLogin() async {
    final Either<LoginCredsResponseE, LoginResponseS> loginResponse =
        await api.loginWithRefreshToken();
    if (api.responseIsError(loginResponse)) {
      switch (loginResponse) {
        case Left(LoginCredsResponseE.INVALID_CREDENTIALS):
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Incorrect credentials'),
          ));
          return;
        case Left(LoginCredsResponseE.INTERNAL_SERVER_ERROR):
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Oops! Something went wrong'),
          ));
          return;
      }
      Navigator.popAndPushNamed(context, "/login", arguments: true);
    }
  }

  login() async {
    if (nameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final Either<LoginCredsResponseE, LoginResponseS> loginResponse =
          //await api.login("Kai", "Yeetyeet1!");
          await api.login(
        nameController.text.toString(),
        passwordController.text.toString(),
      );
      if (api.responseIsError(loginResponse)) {
        switch (loginResponse.left) {
          case LoginCredsResponseE.INVALID_CREDENTIALS:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Incorrect credentials'),
            ));
            return;
          case LoginCredsResponseE.INTERNAL_SERVER_ERROR:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Oops! Something went wrong'),
            ));
            return;
        }
      }
      Navigator.pushNamed(context, "/",
          arguments: LoginInfo(loggenIn: true, ready: true));
    } else {
      _validate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Gymlife'),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Column(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        )),
                    CostumTextField(
                        controller: nameController,
                        validate: _validate,
                        text: "Mail Adress"),
                    CostumTextField(
                        controller: passwordController,
                        validate: _validate,
                        obscure: true,
                        text: "Password"),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/forgot_password");
                      },
                      child: Text(
                        "forgot password",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            // login method
                            login();
                            // pop keyboard
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        )),
                    Container(
                        child: Row(
                      children: <Widget>[
                        Text('Don\'t have an account?'),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/sign_up");
                          },
                          child: Text(
                            "sign up",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, "/landing");
                  Navigator.pushNamed(context, Routes.landing,
                      arguments: LoginInfo(loggenIn: false, ready: true));
                },
                child: Text(
                  "Continue without account",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ]),
        ));
  }
}
