import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrackingPage extends StatefulWidget {
  TrackingPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Center(child: Image.asset('assets/images/stub.png')));
       // child: Center(
       //      child: Column(children: [
       //      Padding(
       //      padding: EdgeInsets.only(top: 32),
       //      child:Text(
       //      'Датчики активированы',
       //      style: TextStyle(fontSize: 26),
       //    )),
       //    Padding(
       //        padding: EdgeInsets.only(left: 32, right: 32, top: 28),
       //        child: ButtonTheme(
       //            height: 64,
       //            minWidth: double.infinity,
       //            child: RaisedButton(
       //              onPressed: () {
       //                http.get('https://json.flutter.su/echo').then((response) {
       //                  print("Response status: ${response.statusCode}");
       //                  print("Response body: ${response.body}");
       //                }).catchError((error){
       //                  print("Error: $error");
       //                });
       //              },
       //              textColor: Colors.white,
       //              color: Colors.red,
       //              child:
       //                  Text('Начать смену', style: TextStyle(fontSize: 26)),
       //            ))),
       //        Padding(
       //            padding: EdgeInsets.only(left: 32, right: 32, top: 16),
       //            child: ButtonTheme(
       //                height: 64,
       //                minWidth: double.infinity,
       //                child: RaisedButton(
       //                  onPressed: () {
       //                    // Navigator.pushNamed(context, '/ProfilePage');
       //                  },
       //                  textColor: Colors.white,
       //                  color: Colors.red,
       //                  child:
       //                  Text('Завершить смену', style: TextStyle(fontSize: 26)),
       //                )))
       //  ])));
  }
}
