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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [topColor, bottomColor]),
          ),
          child: SingleChildScrollView(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 15,
                ),
                child: Image.asset(
                  "assets/logo_fundo_transparente.png",
                  height: 125,
                ),
              ),
              Text(
                "Entrar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        decoration:
                        InputDecoration(
                          labelText: "E-mail",
                            labelStyle:  TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                                Icons.mail_outline,
                              color: Colors.white,
                            ),
                          border: UnderlineInputBorder(
                          borderSide:BorderSide(
                            color: Colors.white,
                          ),
                        ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:BorderSide(
                                color: Colors.white,
                              ),
                            ),
                        ),
                      ),
                      TextFormField(
                        decoration:
                        InputDecoration(
                          labelText: "Senha",
                          labelStyle:  TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.vpn_key_off_sharp,
                            color: Colors.white,
                          ),
                          border: UnderlineInputBorder(
                            borderSide:BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: 7)
              ),
              Text("Esqueceu a senha?", textAlign: TextAlign.right,)
            ],
          ) ,
    ),
      ),
    );
  }
}
