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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 500,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/chapeu.png',
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 500,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(horizontal: 75.75),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLoginButton(context),
                    _buildRegisterButton(context),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                child: Column(
                  children: [
                    Form(
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: Colors.black),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Form(
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(color: Colors.black),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    GestureDetector(
                      child: Text(
                        "Esqueci minha senha",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 4, color: Colors.orange)),
      ),
      child: TextButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          // Lógica para processar o login
        },
        child: Text(
          'Entrar',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      onPressed: () {
        // Lógica para redirecionar para a tela de registro
      },
      child: Text('Cadastrar', style: TextStyle(color: Colors.black)),
    );
  }
}
