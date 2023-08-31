import 'package:customer_app/pages/login.dart';
import 'package:flutter/material.dart';

class RouterContext {
  BuildContext context;

  List<Map<String, Object>> routes = [
    {
      'path': '/home',
      'name': 'Home',
      'page': Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const Center(
          child: Text('Home'),
        )
      ),
    },
    {
      'path': '/forgot-password',
      'name': 'Forgot password',
      'page': Scaffold(
        appBar: AppBar(
          title: const Text('Forgot password'),
        ),
        body: const Center(
          child: Text('Forgot password'),
        ),
      ),
    },
    {
      'path': '/sign-up',
      'name': 'Sign up',
      'page': Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
        ),
        body: const Center(
          child: Text('Sign up'),
        ),
      ),
    },
    {'path': '/login', 'name': 'Login', 'page': const LoginPage()}
  ];

  RouterContext(this.context);

  Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> routesToReturn = {};

    for (var route in routes) {
      routesToReturn[route['path'] as String] =
          (BuildContext context) => route['page'] as Widget;
    }

    return routesToReturn;
  }

  void goTo(String name) {
    var route =
        routes.firstWhere((r) => r['name'] == name, orElse: () => routes[0]);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => route['page'] as Widget),
        (route) => false);
  }
}