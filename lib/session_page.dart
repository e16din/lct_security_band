import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class SessionPage extends StatefulWidget {
  SessionPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SessionPageState createState() => _SessionPageState();
}

bool _sessionStateStarted = false;

class _SessionPageState extends State<SessionPage> {
  ProgressDialog progressDialog;

  var _sessionButtonText = '';

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);
    progressDialog.style(
      message: 'Пожалуйста подождите..',
    );

    _requestSessionState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Column(children: [
      Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 28),
        child: Text("Смена", style: TextStyle(fontSize: 32)),
      )),
      Padding(
          padding: EdgeInsets.only(left: 32, right: 32, top: 48),
          child: ButtonTheme(
              height: 64,
              minWidth: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  _toggleSessionState();
                },
                textColor: Colors.white,
                child: Text(_sessionButtonText, style: TextStyle(fontSize: 26)),
              ))),
      Visibility(
        visible: _sessionStateStarted,
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Text(
            'Датчики активированы',
            style: TextStyle(fontSize: 26),
          ),
        ),
      ),
    ])));
  }

  bool _requestSessionState() {
    progressDialog.show();

    // todo: change api
    http.get('https://json.flutter.su/echo').then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      updateSessionState(_sessionStateStarted); //todo: check state
      hideProgressDialog();
    }).catchError((error) {
      print("Error: $error");
      _sessionButtonText = '';
      hideProgressDialog();
    });

    return _sessionStateStarted;
  }

  void hideProgressDialog() {
    Future.delayed(Duration(milliseconds: 600)).then((value) {
      progressDialog.hide();
    });
  }

  void updateSessionState(bool sessionState) {
    setState(() {
      _sessionStateStarted = sessionState;
      if (_sessionStateStarted) {
        _sessionButtonText = 'Завершить смену';
      } else {
        _sessionButtonText = 'Начать смену';
      }
    });
  }

  _toggleSessionState() async {
    progressDialog.show();
    // todo: change api
    http.get('https://json.flutter.su/echo').then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      updateSessionState(!_sessionStateStarted); //todo: check state

      hideProgressDialog();
    }).catchError((error) {
      print("Error: $error");
      hideProgressDialog();
    });
  }
}
