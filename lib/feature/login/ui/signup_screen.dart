import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/feature/login/recources/real_api.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController prefixController = TextEditingController();

  bool _validate = false;

  register() {
    RealApi api = new RealApi();

    if (nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty) {
      api.register(
        // TODO retrieve values from text controllers
        "arie_bisfki@live.nl",
        "Yeetyeet1!",
        'images/bench.jpg',
        "Arnold",
        "S",
        "",
      );
      Navigator.popAndPushNamed(context, "/landing");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Yay! Register succes'),
      ));
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
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
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
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    //controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Picture (TODO)',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: firstnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First name',
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: lastnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last name',
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: prefixController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Prefix',
                    ),
                  ),
                ),
                Container(
                    height: 70,
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text(
                        'Create account',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        register();
                        // pop keyboard
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ))
              ],
            )));
  }
}
