import 'package:customer_app/data/types.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/services/customer.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/ui/data/custom_colors.dart';

class CartItem {
  final String nomePrato;
  final double precoPrato;
  final int idPrato;
  final String imageUrl;
  final int cheffId;
  int quantity;
  double total;

  CartItem(this.nomePrato, this.precoPrato, this.idPrato, this.imageUrl, this.quantity, this.cheffId, this.total);
}

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPage();
}

class _OrderDetailsPage extends State<OrderDetailsPage> {
  List<CartItem> carrinhoItens = [];
  int idCart = 0;

  @override
  void initState() {
    super.initState();
    buscarCart();
  }

  buscarCart() async {
    UserProvider userProvider = readUserProvider(context);
    Response response = await CustomerService().getOrders(token: userProvider.user?.token ?? "");
    double total = 0;
    if (response.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: CustomColors.error,
        ),
      );
    } else {
      List<dynamic> carts = (response as CustomerGetOrdersResponse).carts;
      if (carts.isNotEmpty) {
        dynamic lastCart = carts.last;
        idCart = lastCart["id"];

        List<dynamic> cartItems = lastCart['cartItems'];
        carrinhoItens = cartItems.where((item) => item['quantity'] > 0).map((item) {
          Map<String, dynamic> foodPlate = item['foodPlate'];
          int idPlate = foodPlate['id'];
          String namePlate = foodPlate['name'];
          int cheffId = foodPlate['cheffId'];
          String imageUrlPlate = foodPlate['imageUrl'];
          String pricePlate = foodPlate['price'].toString();
          int quantity = item['quantity'];

          double priceDoublePlate = double.parse(pricePlate);

          total = total + (priceDoublePlate * quantity);
          return CartItem(namePlate, priceDoublePlate, idPlate, imageUrlPlate, quantity, cheffId, total);
        }).toList();
      }

      setState(() {});
    }
  }

  finalizeCart(int idCart, BuildContext context) async {
    UserProvider userProvider = readUserProvider(context);
    RouterContext router = RouterContext(context);

    Response response = await CustomerService().finalizeCart(
      token: userProvider.user?.token ?? "",
      idCart: idCart,
    );

    if (response.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: CustomColors.error,
        ),
      );
    } else {
      router.goTo("Orders");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      currentRoute: "Order Details",
      title: "Pedido",
      child: Column(
        children: [
          const Row(children: [
            Padding(padding: EdgeInsets.only(left: 35)),
            Text("Informações", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
          ]),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Pedido',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: CustomColors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 276,
                        child: ListView(
                          children: carrinhoItens.map((item) {
                            return aaa(item);
                          }).toList(),
                        )),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontSize: 20),
              ),
              if (carrinhoItens.isNotEmpty)
                Text(
                  carrinhoItens.last.total.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              else
                const Text(
                  "0.0",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(bottom: 55.0),
            width: 300,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                finalizeCart(idCart, context);
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
                'Enviar pedido para o chefe',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class aaa extends StatefulWidget {
  final CartItem item;

  const aaa(this.item, {Key? key}) : super(key: key);

  @override
  State<aaa> createState() => _aaa();
}

class _aaa extends State<aaa> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '● - ${widget.item.nomePrato}\t(${widget.item.quantity})',
        ),
      ],
    );
  }
}
