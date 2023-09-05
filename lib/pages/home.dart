import 'package:customer_app/templates/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AuthTemplate(
      currentRoute: 'Home',
      child: Center(
        child: Text('Home'),
      ),
    );
  }
}
