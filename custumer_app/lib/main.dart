import 'package:customer_app/pages/login.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:customer_app/ui/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: CustomColors.palette,
      ),
      title: 'Go Cheff',
      routes: router.getRoutes(),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
