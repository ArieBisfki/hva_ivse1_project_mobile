import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ivse1_gymlife/feature/login/recources/real_api.dart';

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

  login() {
    // token in storage?
    //-> login with token
    // RealiAPI.login(token);
    RealApi api = new RealApi();

    String token = storage.read(key: "accessToken").toString();

    if (token.isNotEmpty) {
      //if (token.isEmpty) {
      api.login("kai", "Yeetyeet1!");
    } else {
      api.loginWithToken(token);
    }

    //TODO add login = true argument to remove "dont have an account"
    Navigator.popAndPushNamed(context, "/landing");
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
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
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
                  Navigator.pushNamed(context, "/landing");
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
