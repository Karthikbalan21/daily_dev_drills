import 'package:flutter/material.dart';
import 'package:daily_dev_drills/pages/login_page.dart';
import 'package:daily_dev_drills/pages/register_page.dart';
import 'package:daily_dev_drills/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(username: 'karthik', email: 'karthik@gmail.com',),
      },
    );
  }
}
