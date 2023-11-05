import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_app/data/local_storage.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/services/cheff.dart';
import 'package:customer_app/states/cheffs.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:customer_app/ui/components/loading_spinner.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:customer_app/utils/ellipsis_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getCheffs(context);
  }

  void getCheffs(context, {bool force = false}) async {
    UserState? user = getUserState(context);

    if (user == null) return;

    if (user.cheffs != null && !force) return;

    setState(() {
      isLoading = true;
    });

    String token = (await localStorageRead('token'))!;

    Response response = await CheffService().getAll(
        token: token,
        mainCuisine: user.mainCuisine,
        glutenFree: user.glutenFree,
        lactoseFree: user.lactoseFree,
        vegan: user.vegan,
        vegetarian: user.vegetarian,
        light: user.light);

    if (!response.error) {
      UserProvider userProvider = readUserProvider(context);

      dynamic cheffs = (response as CheffGetAllResponse).cheffs;

      List<CheffState> cheffsState = [];
      List<String> possibleMainCuisines = [];

      for (var cheff in cheffs) {
        if (cheff['registerStatus'] != 'approved') continue;

        cheffsState.add(CheffState.fromJson(cheff));

        if (user.mainCuisine != null ||
            user.glutenFree == true ||
            user.lactoseFree == true ||
            user.vegan == true ||
            user.vegetarian == true ||
            user.light == true) continue;

        if (possibleMainCuisines.contains(cheff['mainCuisine'])) continue;

        possibleMainCuisines.add(cheff['mainCuisine']);
      }

      userProvider.setCheffs(cheffsState);

      if (user.mainCuisine == null &&
          user.glutenFree != true &&
          user.lactoseFree != true &&
          user.vegan != true &&
          user.vegetarian != true &&
          user.light != true) {
        userProvider.setPossibleMainCuisines(possibleMainCuisines);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: CustomColors.error,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void changeFilter(context, String filter) async {
    UserProvider userProvider = readUserProvider(context);
    UserState user = userProvider.user!;

    if (filter == "glutenFree") {
      userProvider.setGlutenFree(user.glutenFree == null || user.glutenFree == false ? true : false);
    } else if (filter == "lactoseFree") {
      userProvider.setLactoseFree(user.lactoseFree == null || user.lactoseFree == false ? true : false);
    } else if (filter == "vegan") {
      userProvider.setVegan(user.vegan == null || user.vegan == false ? true : false);
    } else if (filter == "vegetarian") {
      userProvider.setVegetarian(user.vegetarian == null || user.vegetarian == false ? true : false);
    } else if (filter == "light") {
      userProvider.setLight(user.light == null || user.light == false ? true : false);
    }

    getCheffs(context, force: true);
  }

  String getFilterValue(context, String filter) {
    UserProvider userProvider = readUserProvider(context);
    UserState user = userProvider.user!;

    if (filter == "glutenFree" && user.glutenFree == true) {
      return filter;
    } else if (filter == "lactoseFree" && user.lactoseFree == true) {
      return filter;
    } else if (filter == "vegan" && user.vegan == true) {
      return filter;
    } else if (filter == "vegetarian" && user.vegetarian == true) {
      return filter;
    } else if (filter == "light" && user.light == true) {
      return filter;
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    UserState? user = watchUserState(context);
    UserProvider userProvider = readUserProvider(context);

    return AuthTemplate(
      currentRoute: 'Home',
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FilterInputs(),
              CarouselSlider(
                items: [
                  ["glutenFree", "Gluten Free"],
                  ["lactoseFree", "Lactose Free"],
                  ["vegetarian", "Vegetariana"],
                  ["vegan", "Vegana"],
                  ["light", "Light"]
                ]
                    .map((e) => Row(children: [
                          Checkbox(
                            value: getFilterValue(context, e[0]) == e[0],
                            onChanged: (value) {
                              changeFilter(context, e[0]);
                            },
                          ),
                          Text(e[1])
                        ]))
                    .toList(),
                options: CarouselOptions(
                  height: 50,
                  viewportFraction: 0.4,
                  enableInfiniteScroll: false,
                ),
              ),
              CarouselSlider(
                items: user != null && user.possibleMainCuisines != null
                    ? user.possibleMainCuisines!.map((e) {
                        return CuisineFilterItem(
                          cuisine: e,
                          isSelected: e == user.mainCuisine,
                          onCuisineSelected: (cuisine) {
                            setState(() {
                              if (cuisine == user.mainCuisine) {
                                userProvider.setMainCuisine(null);
                              } else {
                                userProvider.setMainCuisine(cuisine);
                              }

                              getCheffs(context, force: true);
                            });
                          },
                        );
                      }).toList()
                    : [],
                options: CarouselOptions(
                  height: 40,
                  viewportFraction: 0.3,
                  enableInfiniteScroll: false,
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LoadingSpinner(),
                        ],
                      ),
                    )
                  : CarouselSlider(
                      items: user != null && user.cheffs != null
                          ? user.cheffs!
                              .map(
                                (chef) => ChefCard(chef),
                              )
                              .toList()
                          : [],
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 0.50,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.15,
                        enableInfiniteScroll: false,
                      ),
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ChefCard extends StatelessWidget {
  final CheffState cheff;

  const ChefCard(this.cheff, {super.key});

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    return GestureDetector(
      onTap: () {
        router.goTo('Cheff', arguments: {
          'cheffId': cheff.id,
          'cheffName': cheff.name,
        });
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
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: CustomColors.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Icon(
                  Icons.person,
                  size: 64.0,
                  color: CustomColors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                ellipsisName(cheff.name),
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                cheff.mainCuisine,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CustomColors.secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CuisineFilterItem extends StatefulWidget {
  final String cuisine;
  final bool isSelected;
  final Function(String) onCuisineSelected;

  const CuisineFilterItem({
    Key? key,
    required this.cuisine,
    required this.isSelected,
    required this.onCuisineSelected,
  }) : super(key: key);

  @override
  _CuisineFilterItemState createState() => _CuisineFilterItemState();
}

class _CuisineFilterItemState extends State<CuisineFilterItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onCuisineSelected(widget.cuisine);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: widget.isSelected
              ? const Border(
                  bottom: BorderSide(
                    color: CustomColors.secondary,
                    width: 4,
                  ),
                )
              : null,
        ),
        child: Center(
          child: Text(
            widget.cuisine,
            style: TextStyle(
              color: widget.isSelected ? CustomColors.secondary : CustomColors.gray,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}

class FilterInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          constraints: const BoxConstraints(minWidth: 1000),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Cidade',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
