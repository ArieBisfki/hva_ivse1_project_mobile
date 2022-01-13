import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/common/widget/textfield.dart';
import 'package:ivse1_gymlife/feature/login/recources/real_api.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController prefixController = TextEditingController();

  bool _validate = false;

  register() {
    RealApi api = new RealApi();

    if (nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty) {
      api.register(
          nameController.text,
          passwordController.text,
          emailController.text,
          firstnameController.text,
          lastnameController.text,
          prefixController.text);
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
                CostumTextField(
                    controller: nameController,
                    validate: _validate,
                    text: 'Email'),
                CostumTextField(
                    controller: passwordController,
                    validate: _validate,
                    text: 'Password'),
                CostumTextField(
                    controller: emailController,
                    validate: _validate,
                    text: 'User Name'),
                CostumTextField(
                    controller: firstnameController,
                    validate: _validate,
                    text: 'First name'),
                CostumTextField(
                    controller: lastnameController,
                    validate: _validate,
                    text: 'Last name'),
                CostumTextField(
                    controller: prefixController,
                    validate: _validate,
                    text: 'Prefix'),
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
