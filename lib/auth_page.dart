import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<AuthPage> {
  ProgressDialog progressDialog;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  var login = '';
  var password = '';

  var _onLoginClickAction = () {};

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);
    progressDialog.style(
      message: 'Пожалуйста подождите..',
    );

    loginController.addListener(() {
      setState(() {
        login = loginController.text;
        updateLoginClickActionState();
      });
    });

    passwordController.addListener(() {
      setState(() {
        password = passwordController.text;
        updateLoginClickActionState();
      });
    });

    updateLoginClickActionState();
  }

  void updateLoginClickActionState() {
    _onLoginClickAction = areFieldsValid()
        ? () {
            onLoginClick(context);
          }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Center(child: Image.asset('assets/images/auth_bg.png')),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  child: ColoredBox(
                      color: Color(0xa1ffffff),
                      child: TextFormField(
                        controller: loginController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Логин',
                            hintStyle: TextStyle(fontSize: 24)),
                        style: TextStyle(fontSize: 24, color: Colors.blue),
                      ))),
              Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 64),
                  child: ColoredBox(
                      color: Color(0xa1ffffff),
                      child: TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Пароль',
                            hintStyle: TextStyle(fontSize: 24)),
                        style: TextStyle(fontSize: 24),
                      ))),
              Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: ButtonTheme(
                    height: 64,
                    minWidth: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                          side: BorderSide(color: Colors.blue)),
                      onPressed: _onLoginClickAction,
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Добро пожаловать!',
                          style: TextStyle(fontSize: 21)),
                    ),
                  ))
            ],
          ),
        ]));
  }

  bool areFieldsValid() {
    return login.isNotEmpty && password.isNotEmpty;
  }

  //todo: fix second login without login/pass issue (may be stateful)
  void onLoginClick(BuildContext context) {
    progressDialog.show();
    loginController.clear();
    passwordController.clear();

    http
        .post('http://ldt-transformation.nemezida.online/auth/register',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'login': login,
              'password': password,
            }))
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      Future.delayed(Duration(milliseconds: 600)).then((value) {
        progressDialog.hide();

        if (response.body.contains('User exists')) {
          Navigator.pushNamed(context, '/MainPage');
        }
      });
    }).catchError((error) {
      print("Error: $error");
      hideProgressDialog();
    });
  }

  void hideProgressDialog() {
    Future.delayed(Duration(milliseconds: 600)).then((value) {
      progressDialog.hide();
    });
  }
}
