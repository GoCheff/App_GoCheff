import 'package:customer_app/data/local_storage.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    return AuthTemplate(
      currentRoute: 'Profile',
      title: "Perfil",
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 33, left: 33, right: 33, bottom: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF393939).withOpacity(0.03),
                      offset: const Offset(0, 30),
                      blurRadius: 60,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: CustomColors.secondary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 64.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            watchUserState(context)?.name ?? "",
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            watchUserState(context)?.email ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BoxOption(
                  router: router,
                  title: "Pedidos",
                  action:  () {
                    router.goTo('Orders');
                  }),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                  child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(CustomColors.primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 19)),
                      ),
                      onPressed: () async {
                        UserProvider userProvider = readUserProvider(context);
                        userProvider.removeUser();
                        localStorageRemove("token");

                        router.goTo('Login');
                      },
                      child: const Text('Sair',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxOption extends StatelessWidget {
  final RouterContext router;
  final String title;
  final Function action;

  const BoxOption({
    super.key,
    required this.router,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {
          action();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(CustomColors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 18, bottom: 18, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.black),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: CustomColors.black,
                size: 20.0,
              ),
            ],
          ),
        ));
  }
}
