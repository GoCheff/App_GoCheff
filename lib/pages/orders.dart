import 'package:customer_app/templates/auth.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthTemplate(
      currentRoute: 'Orders',
      title: "Pedidos",
      child: Center(
        child: Text('Orders'),
      ),
    );
  }
}
