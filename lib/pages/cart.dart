import 'package:customer_app/data/types.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/services/customer.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import '../utils/ellipsis_text.dart';

class CartItem {
  final String namePlate;
  final double pricePlate;
  final int idPlate;
  final String imageUrl;
  final int cheffId;
  int quantity;
  final String status;


 CartItem(this.nomePrato, this.precoPrato, this.idPrato, this.imageUrl, this.quantity, this.cheffId, this.status);


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItens = [];

  @override
  void initState() {
    super.initState();
    searchCart();
  }

  searchCart() async {
    UserProvider userProvider = readUserProvider(context);
    Response response = await CustomerService().getOrders(token: userProvider.user?.token ?? "");
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
        dynamic ultimoCarrinho = carts.last;
        String status = ultimoCarrinho["status"];
        List<dynamic> cartItems = ultimoCarrinho['cartItems'];
        carrinhoItens = cartItems.where((item) => item['quantity'] > 0).map((item) {

          Map<String, dynamic> foodPlate = item['foodPlate'];
          int idPlate = foodPlate['id'];
          String namePlate = foodPlate['name'];
          int cheffId = foodPlate['cheffId'];
          String imageUrlPlate = foodPlate['imageUrl'];
          String pricePlate = foodPlate['price'].toString();
          int quantity = item['quantity'];

          double priceDoublePlate = double.parse(pricePlate);
          return CartItem(namePlate, priceDoublePlate, idPlate, imageUrlPlate, quantity, cheffId, status);
        }).toList();
      }

      setState(() {});
    }
  }

  void removeItemCart(int id) {
    cartItens.removeWhere((item) => item.idPlate == id);
    setState(() {});
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
                Icons.pan_tool_alt_rounded, //Alterar o ícone
                size: 24,
                color: Color.fromARGB(255, 160, 32, 32),
              ),
              SizedBox(width: 5),
              Text("Deslize em um item para excluir"),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: cartItens.map((item) {
                return CardItem(item, () {
                  removeItemCart(item.idPlate);
                });
              }).toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 55.0),
            width: 300,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                RouterContext router = RouterContext(context);
                router.goTo("Order Details");
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

class CardItem extends StatefulWidget {
  final CartItem item;
  final Function onRemove;

  const CardItem(this.item, this.onRemove, {Key? key}) : super(key: key);

  @override
  State<CardItem> createState() => _CardItem();
}

class _CardItem extends State<CardItem> {
  updateItemCart(BuildContext context, CartItem cartItem) async {
    UserProvider userProvider = readUserProvider(context);

    Response response = await CustomerService().updateOrCreateCartItem(
      token: userProvider.user?.token ?? "",
      foodPlateId: cartItem.idPlate,
      quantity: cartItem.quantity,
      cheffId: cartItem.cheffId,
      locale: "",
    );

    if (response.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: CustomColors.error,
        ),
      );
    } else {
      setState(() {});
    }
  }

  double valorTotal = 0;

  void removeItem() {
    widget.onRemove();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.status != "open") {
      return SizedBox.shrink();
    }

    return Dismissible(
      key: Key(widget.item.idPlate.toString()),
      background: Container(
        color: CustomColors.white,
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          widget.item.quantity = 0;
          updateItemCart(context, widget.item);
          removeItem();
        }
      },
      child: Center(
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
                child: Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(widget.item.imageUrl),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Column(children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        widget.item.namePlate,
                        style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${widget.item.pricePlate * widget.item.quantity}",
                        style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ]),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (widget.item.quantity > 1) {
                              widget.item.quantity--;
                              updateItemCart(context, widget.item);
                            }
                          });
                        },
                      ),
                      Text(
                        (widget.item.quantity).toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            widget.item.quantity++;
                            updateItemCart(context, widget.item);
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
