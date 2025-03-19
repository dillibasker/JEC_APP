import 'package:flutter/material.dart';
import 'pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/homepage.dart'; // Import the Login Page

void main()async {

 WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString("userId");

  runApp(MyApp(startPage: userId == null ? LoginPage() : HomePage()));
  }


class MyApp extends StatelessWidget {
final Widget startPage;
  MyApp({required this.startPage});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startPage,
    );
  }
}
