import 'package:customer_app/assets/icons/orders_icon.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    return AuthTemplate(
      currentRoute: 'Orders',
      title: "Pedidos",
      child: Center(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 33, left: 33, right: 33, bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                const Column(
                  children: [
                    OrdersIcon(width: 80, height: 80, fill: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      'Nenhum pedido\npor enquanto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Aperte o botão abaixo\npara fazer um pedido.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    )
                  ],
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Row(children: [
                  Expanded(
                    child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(CustomColors.secondary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 19)),
                        ),
                        onPressed: () async {
                          router.goTo('Home');
                        },
                        child: const Text('Fazer um pedido',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))),
                  ),
                ])
              ],
            )),
      ),
    );
  }
}
