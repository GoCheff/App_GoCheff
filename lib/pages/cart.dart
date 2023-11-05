import 'package:customer_app/pages/foodplate.dart';
import 'package:customer_app/states/carts.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import '../utils/ellipsis_text.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<FoodPlateArguments> items = [];

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = readUserProvider(context);
    CartState? cartState = userProvider.user?.carts?.last;
    List<CartItem>? cartItens = cartState?.cartItems;

    List<Widget> itemCarrinhoWidgets = [];
    if (cartItens != null) {
      for (CartItem cartItem in cartItens) {
        itemCarrinhoWidgets.add(ItemCarrinho(cartItem.foodPlate?.name ?? "", cartItem.foodPlate?.price.toDouble() ?? 00,
            cartItem.foodPlate?.id.toInt() ?? 0, cartItem.foodPlate?.imageUrl ?? ""));
      }
    }
    return AuthTemplate(
      currentRoute: 'Cart',
      title: ellipsisName("Carrinho"),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pan_tool_alt_rounded, //Alterar o icone
                size: 24,
                color: Color.fromARGB(255, 160, 32, 32),
              ),
              SizedBox(width: 5),
              Text("Deslize em um item para excuir"),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView(
            children: itemCarrinhoWidgets,
          )),
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

class ItemCarrinho extends StatefulWidget {
  final String nomePrato;
  final double precoPrato;
  final int idPrato;
  final String imageUrl;
  const ItemCarrinho(this.nomePrato, this.precoPrato, this.idPrato, this.imageUrl, {Key? key}) : super(key: key);

  @override
  State<ItemCarrinho> createState() => _ItemCarrinho();
}

class _ItemCarrinho extends State<ItemCarrinho> {
  int cont = 0;
  double valorTotal = 0;
  @override
  Widget build(BuildContext context) {
    void removeItemCart(int id) {
      UserProvider userProvider = readUserProvider(context);
      List<CartState>? cartStateList = userProvider.user?.carts;

      if (cartStateList != null && cartStateList.isNotEmpty) {
        CartState lastCartState = cartStateList.last;

        int indexToRemove = lastCartState.cartItems!.indexWhere((item) => item.id == id);

        if (indexToRemove != -1) {
          lastCartState.cartItems!.removeAt(indexToRemove);
          userProvider.setCarts(cartStateList);
        }
      }
    }

    return Dismissible(
      key: Key(widget.idPrato.toString()),
      background: Container(
        color: CustomColors.white,
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          removeItemCart(widget.idPrato.toInt());
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
                    backgroundImage: NetworkImage(widget.imageUrl),
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
                          widget.nomePrato,
                          style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
                        )),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: 100,
                        child: Text(
                          "$valorTotal",
                          style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
                        ))
                  ]),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (cont > 0) {
                                cont--;
                                valorTotal = cont * widget.precoPrato;
                              }
                            });
                          }),
                      Text(
                        (cont).toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            cont++;
                            valorTotal = cont * widget.precoPrato;
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
