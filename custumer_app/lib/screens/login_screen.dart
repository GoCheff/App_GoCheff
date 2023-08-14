import 'package:flutter/material.dart';
import 'package:custumer_app/screens/login_screen.dart';
import 'package:custumer_app/screens/home.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();

}
class _LoginScreenState extends State <LoginScreen>{
  Color topColor = Colors.orange;
  Color bottomColor = Color.fromRGBO(
      214,
      134,
      60,
      0.9
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  topColor,
                  bottomColor
                ]),
        ),
     ),
    );
  }
}