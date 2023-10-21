import 'package:customer_app/templates/auth.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import '../utils/ellipsis_text.dart';
import 'package:customer_app/services/cheff.dart';
import 'package:customer_app/pages/cheff.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      currentRoute: 'Cart',
      title: ellipsisName("Carrinho"),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          const Expanded(child: SingleChildScrollView(child: Column())),
          Container(
            margin: EdgeInsets.only(bottom: 55.0),
            width: 300,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(CustomColors.secondary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              child: const Text(
                'Fazer pedido ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
