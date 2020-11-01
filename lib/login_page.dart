import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'auth_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  ProgressDialog progressDialog;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  var loginValue = '';
  var passwordValue = '';

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
        loginValue = loginController.text;
        updateLoginClickActionState();
      });
    });

    passwordController.addListener(() {
      setState(() {
        passwordValue = passwordController.text;
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
    return loginValue.isNotEmpty && passwordValue.isNotEmpty;
  }

  //todo: fix second login without login/pass issue (may be stateful)
  void onLoginClick(BuildContext context) {
    progressDialog.show();

    var passBytes = utf8.encode(passwordValue);
    var hashpass = sha256.convert(passBytes).toString();
    var localLogin = loginValue;
    var json = jsonEncode(<String, dynamic>{
      'login': localLogin,
      'hashpass': hashpass,
    });
    print('request: $json');

    loginController.clear();
    passwordController.clear();

    http
        .post('http://ldt-transformation.nemezida.online/api/worker/login',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json)
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      Future.delayed(Duration(milliseconds: 600)).then((value) {
        progressDialog.hide();

        if (response.statusCode == 200) {
          var parsedJson = jsonDecode(response.body);
          token = parsedJson['token'];
          login = localLogin;

          print("token: $token");

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
