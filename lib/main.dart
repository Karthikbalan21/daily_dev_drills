import 'package:daily_dev_drills/firebase_options.dart';
import 'package:daily_dev_drills/pages/code_editor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:daily_dev_drills/pages/login_page.dart';
import 'package:daily_dev_drills/pages/register_page.dart';
import 'package:daily_dev_drills/pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
void testDB() async
{
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference reference = firebaseDatabase.ref('users');
  await reference.set({
    "name":"Karthik Balan",
    "age":18
  });
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
