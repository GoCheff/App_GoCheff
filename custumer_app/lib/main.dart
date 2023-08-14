import 'package:flutter/material.dart';
import 'package:custumer_app/screens/login_screen.dart';
import 'package:custumer_app/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Cheffe',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}