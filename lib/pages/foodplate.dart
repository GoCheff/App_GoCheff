import 'package:customer_app/data/types.dart';
import 'package:customer_app/services/customer.dart';
import 'package:customer_app/states/carts.dart';
import 'package:customer_app/states/cheffs.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/utils/download_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:provider/provider.dart';

class FoodPlatePage extends StatefulWidget {
  const FoodPlatePage({super.key});

  @override
  State<FoodPlatePage> createState() => _FoodPlatePage();
}

class _FoodPlatePage extends State<FoodPlatePage> {
  addItemCart(CartItem cartItem, int cheffId) async {
    UserProvider userProvider = readUserProvider(context);

    Response response = await CustomerService().updateOrCreateCartItem(
      token: userProvider.user?.token ?? "",
      foodPlateId: cartItem.foodPlateId,
      quantity: cartItem.quantity,
      cheffId: cheffId,
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
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    FoodPlateArguments foodPlateArguments = FoodPlateArguments.fromJson(args as Map<String, dynamic>);
    UserProvider userProvider = context.read<UserProvider>();

    List<CartState>? cartState = userProvider.user?.carts;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 22.0, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(top: 16.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColors.secondary,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      child: FutureBuilder<String>(
                        future: downloadImage(foodPlateArguments.foodPlate.imageUrl),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Icon(
                                Icons.fastfood,
                                size: 64.0,
                                color: CustomColors.black,
                              );
                            }

                            return Image.network(snapshot.data!, fit: BoxFit.cover,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return const Icon(
                                Icons.fastfood,
                                size: 64.0,
                                color: CustomColors.black,
                              );
                            });
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Text(
                    foodPlateArguments.foodPlate.name,
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                    child: Text(
                      foodPlateArguments.foodPlate.price.toString(),
                      style: const TextStyle(
                        color: CustomColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Descrição ',
                          style: TextStyle(
                            color: CustomColors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w200,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          foodPlateArguments.foodPlate.description,
                          style: const TextStyle(
                            color: CustomColors.gray,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            width: 300,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                CartItem cartItem = CartItem(
                    id: foodPlateArguments.foodPlate.id,
                    cartId: 0,
                    foodPlateId: foodPlateArguments.foodPlate.id,
                    quantity: 1,
                    createdAt: DateTime.now(),
                    foodPlate: foodPlateArguments.foodPlate);
                addItemCart(cartItem, foodPlateArguments.cheffId);
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
                'Adicionar ao carrinho',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodPlateArguments {
  int cheffId;
  FoodPlate foodPlate;

  FoodPlateArguments({required this.cheffId, required this.foodPlate});

  factory FoodPlateArguments.fromJson(Map<String, dynamic> json) {
    return FoodPlateArguments(cheffId: json['cheffId'], foodPlate: json['foodPlate']);
  }
}
