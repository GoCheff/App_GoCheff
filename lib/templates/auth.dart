import 'package:customer_app/assets/icons/menu_icon.dart';
import 'package:customer_app/data/local_storage.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/material.dart';

class AuthTemplate extends StatelessWidget {
  final Widget child;
  final String? title;
  final String currentRoute;

  const AuthTemplate({
    super.key,
    required this.child,
    this.title,
    this.currentRoute = "",
  });

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    final bool showBackButton = title != null;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        title: Center(
            child: Text(title ?? "",
                style: const TextStyle(
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18))),
        forceMaterialTransparency: true,
        leading: showBackButton
            ? IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.arrow_back_ios, color: CustomColors.black, size: 20),
                onPressed: () {
                  router.pop();
                },
              )
            : Builder(
                builder: (context) => IconButton(
                  splashRadius: 20,
                  icon: const MenuIcon(
                      fill: CustomColors.gray, height: 20, width: 20),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
        iconTheme: const IconThemeData(color: CustomColors.gray),
        actions: [
          if (title == null)
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              splashRadius: 20,
              onPressed: () {
                print('cart');
              },
            )
          else
            const SizedBox(width: 48),
        ],
      ),
      drawer: _buildMenuAside(context),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomAppBar(
              color: CustomColors.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      icon: Icon(Icons.home,
                          color: currentRoute == 'Home'
                              ? CustomColors.secondary
                              : CustomColors.gray),
                      onPressed: () {
                        if (currentRoute == 'Home') return;

                        router.goTo('Home');
                      },
                    ),
                    IconButton(
                      splashRadius: 20,
                      icon: Icon(Icons.person,
                          color: currentRoute == 'Profile'
                              ? CustomColors.secondary
                              : CustomColors.gray),
                      onPressed: () {
                        if (currentRoute == 'Profile') return;

                        router.goTo('Profile');
                      },
                    ),
                    IconButton(
                      splashRadius: 20,
                      icon: Icon(Icons.history,
                          color: currentRoute == 'Orders'
                              ? CustomColors.secondary
                              : CustomColors.gray),
                      onPressed: () {
                        if (currentRoute == 'Orders') return;

                        router.goTo('Orders');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuAside(BuildContext context) {
    RouterContext router = RouterContext(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.person,
                  size: 64.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 8.0),
                Text(
                  watchUserState(context)?.name ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              if (currentRoute == 'Home') return;

              router.goTo('Home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              if (currentRoute == 'Profile') return;

              router.goTo('Profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Carrinho'),
            onTap: () {
              Navigator.pop(context);
              if (currentRoute == 'Cart') return;

              router.goTo('Cart');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.pop(context);
              if (currentRoute == 'Orders') return;

              router.goTo('Orders');
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment_outlined),
            title: const Text('Métodos de pagamento'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              UserProvider userProvider = readUserProvider(context);
              userProvider.removeUser();
              localStorageRemove("token");

              router.goTo('Login');
            },
          ),
        ],
      ),
    );
  }
}
