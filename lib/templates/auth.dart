import 'package:customer_app/assets/icons/menu_icon.dart';
import 'package:customer_app/data/local_storage.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/material.dart';

class AuthTemplate extends StatelessWidget {
  final Widget child;
  final bool showTitle;
  final String currentRoute;

  const AuthTemplate({
    super.key,
    required this.child,
    this.showTitle = false,
    this.currentRoute = "",
  });

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        title: showTitle
            ? Text(currentRoute.substring(1).toUpperCase())
            : const Text(''),
        forceMaterialTransparency: true,
        leading: Builder(
            builder: (context) => IconButton(
                  splashRadius: 20,
                  icon: const MenuIcon(
                      fill: CustomColors.gray, height: 20, width: 20),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                )),
        iconTheme: const IconThemeData(color: CustomColors.gray),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            splashRadius: 20,
            onPressed: () {
              print('cart');
            },
          ),
        ],
      ),
      drawer: _buildMenuAside(context),
      body: Stack(
        children: [
          if (showTitle)
            const Positioned(
              top: 16.0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Título',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
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
                          color: currentRoute == 'History'
                              ? CustomColors.secondary
                              : CustomColors.gray),
                      onPressed: () {
                        if (currentRoute == 'History') return;

                        router.goTo('History');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: showTitle ? 64.0 : 0),
            // Leva em consideração o espaço do título
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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.person,
                  size: 64.0,
                  color: Colors.white,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Nome do usuário',
                  style: TextStyle(
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
              if (currentRoute == 'Home') return;

              router.goTo('Home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Pedidos'),
            onTap: () {
              if (currentRoute == 'History') return;

              router.goTo('History');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              if (currentRoute == 'Profile') return;

              router.goTo('Profile');
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
