import 'package:customer_app/pages/home.dart';
import 'package:customer_app/pages/login.dart';
import 'package:customer_app/pages/orders.dart';
import 'package:customer_app/pages/profile.dart';
import 'package:customer_app/pages/signup.dart';
import 'package:flutter/material.dart';

class RouterContext {
  BuildContext context;

  List<Map<String, Object>> routes = [
    {
      'path': '/home',
      'name': 'Home',
      'page': HomePage(),
    },
    {
      'path': '/profile',
      'name': 'Profile',
      'page': ProfilePage(),
    },
    {
      'path': '/orders',
      'name': 'Orders',
      'page': OrdersPage(),
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
      'page': const SignupPage(),
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

    Navigator.pushNamed(context, route['path'] as String);
  }

  void pop() {
    Navigator.pop(context);
  }
}
