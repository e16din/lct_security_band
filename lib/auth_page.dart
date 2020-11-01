import 'package:flutter/material.dart';
import 'package:lct_security_band/login_page.dart';
import 'package:lct_security_band/register_page.dart';

var token = '';
var login = '';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              bottom: TabBar(
                labelStyle: TextStyle(fontSize: 26.0), //For Selected tab
                unselectedLabelStyle: TextStyle(fontSize: 24.0),
                onTap: (index) {
                  // Tab index when user select it, it start from zero
                },
                tabs: [
                  Tab(text: 'Регистрация'),
                  Tab(text: 'Логин'),
                ],
              ),
              title: Text('Марио-трекер'),
            ),
            body: TabBarView(
              children: [RegisterPage(), LoginPage()],
            )));
  }
}
