import 'package:flutter/material.dart';
import 'package:lct_security_band/main_page.dart';
import 'package:lct_security_band/profile_page.dart';
import 'package:lct_security_band/session_page.dart';
import 'auth_page.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() {
    return _AppState();
  }
}

class User {}

class _AppState extends State<App> {
  User _user = User();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LCT SecurityBand App',
      theme:
      ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.cyan[600],
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: AuthPage(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthPage());
      case '/MainPage':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/ProfilePage':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/SessionPage':
        return MaterialPageRoute(builder: (_) => SessionPage());
      default:
        return _errorRoute();
      // return MaterialPageRoute(builder: (_) => Page1());
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text("Error")),
          body: Center(child: Text("Please check the Page")));
    });
  }
}
