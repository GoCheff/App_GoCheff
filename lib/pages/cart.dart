import 'package:customer_app/templates/auth.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import '../utils/ellipsis_text.dart';
import 'package:customer_app/services/cheff.dart';
import 'package:customer_app/pages/cheff.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Widget> cartItems = [
    Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          color: CustomColors.white,
        ),
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage:
                      NetworkImage("https://www.sabornamesa.com.br/media/k2/items/cache/b5b56b2ae93d3dc958cf0c21c9383b18_XL.jpg"), //URL AQUI BURRO
                ),
              ),
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Column(children: [
                  Container(
                      width: 200,
                      child: Text(
                        'Nome do prato',
                        style: TextStyle(fontSize: 18),
                      )),
                  const SizedBox(height: 10),
                  Container(
                      width: 200,
                      child: Text(
                        'RS 50,00',
                        style: TextStyle(fontSize: 18),
                      ))
                ]),
                const SizedBox(width: 10),
                Column(
                  children: [Text('- 1 +')],
                )
              ],
            ),
          ],
        ),
      ),
    ),
  ];

  List<Widget> activeCartItems = [];

  @override
  void initState() {
    super.initState();
    activeCartItems.addAll(cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      currentRoute: 'Cart',
      title: ellipsisName("Carrinho"),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pan_tool_alt_rounded,
                size: 24,
                color: Color.fromARGB(255, 160, 32, 32),
              ),
              SizedBox(width: 5),
              Text("Deslize em um item para excuir"),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: activeCartItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(index.toString()),
                  background: Container(
                    color: CustomColors.gray,
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      // Remova o item da lista ativa
                      activeCartItems.removeAt(index);
                    });
                  },
                  child: activeCartItems[index],
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 55.0),
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
                'Fazer pedido',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
