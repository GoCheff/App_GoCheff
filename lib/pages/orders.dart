import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_app/assets/icons/orders_icon.dart';
import 'package:customer_app/data/local_storage.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/services/customer.dart';
import 'package:customer_app/states/carts.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:customer_app/utils/translate_cart_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool cartsLoaded = false;

  void getCarts(context) async {
    if (getUserState(context) == null) return;

    cartsLoaded = true;

    String token = (await localStorageRead('token'))!;

    Response response = await CustomerService().getOrders(token: token);

    if (!response.error) {
      UserProvider userProvider = readUserProvider(context);

      List<dynamic> carts = (response as CustomerGetOrdersResponse).carts;

      List<CartState> cartsState = [];

      for (var cart in carts) {
        cart.remove('cartItems');
        cartsState.add(CartState.fromJson(cart));
      }

      userProvider.setCarts(cartsState);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: CustomColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserState? user = watchUserState(context);
    RouterContext router = RouterContext(context);

    if (!cartsLoaded) {
      getCarts(context);
    }

    return AuthTemplate(
      currentRoute: 'Orders',
      title: "Pedidos",
      child: Center(
        child: user != null && user.carts != null && user.carts?.isEmpty != true
            ? Column(
                children: [
                  CarouselSlider(
                    items: user.carts!
                        .map((cart) => CartCard(cart: cart))
                        .toList(),
                    options: CarouselOptions(
                      height: 150,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        setState(() {});
                      },
                    ),
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(
                    top: 33, left: 33, right: 33, bottom: 60),
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
                              backgroundColor: MaterialStateProperty.all(
                                  CustomColors.secondary),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ])
                  ],
                )),
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  final CartState cart;

  const CartCard({Key? key, required this.cart}) : super(key: key);

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  void createPayment(context, int cartId) async {
    if (getUserState(context) == null) return;

    String token = (await localStorageRead('token'))!;

    Response response = await CustomerService().createPayment(token: token, cartId: cartId);

    if (!response.error) {
      _launchURL((response as CustomerCreatePaymentResponse).paymentLink);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: CustomColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    return GestureDetector(
        onTap: () {
          if (cart.status == "approved") {
            createPayment(context, cart.id);
          }
        },
        child: Card(
            elevation: 1,
            margin: const EdgeInsets.all(10),
            color: CustomColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
                constraints: const BoxConstraints(minWidth: 1000),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Status: ${translateCartStatus(cart.status)}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      "Local: ${cart.locale}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      "Data de criação: ${DateFormat('dd/MM/yyyy').format(cart.createdAt)}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ))));
  }
}
