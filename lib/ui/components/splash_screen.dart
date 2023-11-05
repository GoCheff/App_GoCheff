import 'package:customer_app/assets/icons/logo_icon.dart';
import 'package:customer_app/data/local_storage.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/router/router.dart';
import 'package:customer_app/services/customer.dart';
import 'package:customer_app/states/user.dart';
import 'package:customer_app/ui/components/loading_spinner.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      auth(context);
    });
  }

  void auth(context) async {
    String? token = await localStorageRead('token');

    if (token != null) {
      Response response = await CustomerService().auth(
        token: token,
      );

      if (!response.error) {
        dynamic user = (response as CustomerAuthResponse).user;
        user['token'] = token;

        UserProvider userProvider = readUserProvider(context);

        UserState newUserState = UserState.fromJson(user);
        userProvider.setUser(newUserState);

        RouterContext router = RouterContext(context);
        router.goTo('Home');
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: CustomColors.error,
          ),
        );
      }
    }

    RouterContext router = RouterContext(context);
    router.goTo('Login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/circle.png',
                  width: 270,
                  height: 270,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoIcon(
                      fill: CustomColors.secondary,
                      width: 175,
                      height: 175,
                    ),
                    LoadingSpinner(),
                    const SizedBox(height: 25),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
