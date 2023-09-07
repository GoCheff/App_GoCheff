import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_app/data/local_storage.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/services/cheff.dart';
import 'package:customer_app/states/cheffs.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:customer_app/utils/ellipsis_text.dart';
import 'package:flutter/material.dart';

class ChefCard extends StatelessWidget {
  final CheffState cheff;

  ChefCard(this.cheff);

  @override
  Widget build(BuildContext context) {
    return Card(
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
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      getCheffs(context);
    });
  }

  void getCheffs(context) async {
    if (getUserState(context) == null) return;

    if (getUserState(context)!.cheffs != null) return;

    String token = (await localStorageRead('token'))!;

    Response response = await CheffService().getAll(token: token);

    if (!response.error) {
      UserProvider userProvider = readUserProvider(context);

      dynamic cheffs = (response as CheffGetAllResponse).cheffs;

      List<CheffState> cheffsState = [];

      for (var cheff in cheffs) {
        cheffsState.add(CheffState.fromJson(cheff));
      }

      userProvider.setCheffs(cheffsState);
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

    return AuthTemplate(
      currentRoute: 'Home',
      child: Center(
        child: Column(
          children: [
            CarouselSlider(
              items: user != null && user.cheffs != null
                  ? user.cheffs!
                      .map(
                        (chef) => ChefCard(chef),
                      )
                      .toList()
                  : [],
              options: CarouselOptions(
                height: 270,
                viewportFraction: 0.45,
                enlargeCenterPage: true,
                enlargeFactor: 0.15,
                enableInfiniteScroll: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
