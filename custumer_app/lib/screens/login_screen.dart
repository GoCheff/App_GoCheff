import 'package:custumer_app/values/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:custumer_app/screens/login_screen.dart';
import 'package:custumer_app/screens/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color topColor = Colors.orange;
  Color bottomColor = Colors.white;
  bool continueConnected = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(

                height: 320,
                width: 500,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(horizontal: 75.75),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLoginButton(context),
                    _buildRegisterButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.9),
      ),
      onPressed: () {
        // Lógica para processar o login
      },
      child: Text(
        'Entrar',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.9),
      ),
      onPressed: () {
        // Lógica para redirecionar para a tela de registro
      },
      child: Text('Cadastrar', style: TextStyle(color: Colors.black)),
    );
  }
}
