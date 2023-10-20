import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_app/data/local_storage.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/services/cheff.dart';
import 'package:customer_app/states/cheffs.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:customer_app/utils/download_image.dart';
import 'package:customer_app/utils/ellipsis_text.dart';
import 'package:customer_app/utils/to_real.dart';
import 'package:flutter/material.dart';

class CheffPage extends StatefulWidget {
  const CheffPage({super.key});

  @override
  State<CheffPage> createState() => _CheffPageState();
}

class CheffPageArguments {
  final int cheffId;
  final String cheffName;

  CheffPageArguments({required this.cheffId, required this.cheffName});

  factory CheffPageArguments.fromJson(Map<String, dynamic> json) {
    return CheffPageArguments(
      cheffId: json['cheffId'],
      cheffName: json['cheffName'],
    );
  }
}

class _CheffPageState extends State<CheffPage> {
  bool platesLoaded = false;
  int cheffId = 0;

  void getFoodPlates(context) async {
    if (getUserState(context) == null) return;

    if (getUserState(context)!.cheffs == null) return;

    if (getUserState(context)!.cheffs!.isEmpty) return;

    CheffState? cheff = getUserState(context)!
        .cheffs
        ?.where((element) => element.id == cheffId)
        .first;

    if (cheff == null) return;

    if (cheff.foodPlates != null) return;

    platesLoaded = true;

    String token = (await localStorageRead('token'))!;

    Response response = await CheffService().get(
      token: token,
      cheffId: cheffId,
    );

    if (!response.error) {
      UserProvider userProvider = readUserProvider(context);

      dynamic cheff = (response as CheffGetResponse).cheff;

      List<FoodPlate> foodPlatesCheffState = [];

      for (var foodPlate in cheff['foodPlates']) {
        foodPlatesCheffState.add(FoodPlate.fromJson(foodPlate));
      }

      userProvider.setCheffFoodPlate(cheffId, foodPlatesCheffState);
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

    final args = ModalRoute.of(context)!.settings.arguments;
    CheffPageArguments cheffPageArguments =
        CheffPageArguments.fromJson(args as Map<String, dynamic>);
    cheffId = cheffPageArguments.cheffId;

    if (!platesLoaded) {
      getFoodPlates(context);
    }

    return AuthTemplate(
      currentRoute: 'Cheff',
      title: ellipsisName(cheffPageArguments.cheffName),
      child: Center(
        child: Column(
          children: [
            CarouselSlider(
              items: user != null &&
                      user.cheffs != null &&
                      user.cheffs!.isNotEmpty &&
                      user.cheffs!
                              .where((element) => element.id == cheffId)
                              .first
                              .foodPlates !=
                          null
                  ? user.cheffs!
                      .where((element) => element.id == cheffId)
                      .first
                      .foodPlates!
                      .map(
                        (foodPlate) => FoodPlateCard(foodPlate),
                      )
                      .toList()
                  : [],
              options: CarouselOptions(
                enlargeCenterPage: true,
                enlargeFactor: 0.15,
                viewportFraction: 0.5,
                enableInfiniteScroll: false,
                scrollDirection: Axis.vertical,
                height: MediaQuery.of(context).size.height * 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodPlateCard extends StatelessWidget {
  final FoodPlate foodPlate;

  const FoodPlateCard(this.foodPlate, {super.key});

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    List<String> propertyTexts = [];

    if (foodPlate.glutenFree) propertyTexts.add("Gluten Free");
    if (foodPlate.lactoseFree) propertyTexts.add("Lactose Free");
    if (foodPlate.vegan) propertyTexts.add("Vegano");
    if (foodPlate.vegetarian) propertyTexts.add("Vegetariano");
    if (foodPlate.light) propertyTexts.add("Light");

    String properties = propertyTexts.join(" - ");

    return GestureDetector(
      onTap: () {
        router.goTo('Order Details', arguments: foodPlate.id);
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
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 125,
                height: 125,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: CustomColors.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: FutureBuilder<String>(
                    future: downloadImage(foodPlate.imageUrl),
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
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
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
              const SizedBox(height: 10),
              Text(
                ellipsisName(foodPlate.name),
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                toReal(foodPlate.price),
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.secondary),
              ),
              Text(
                properties,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.secondary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
