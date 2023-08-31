import 'package:customer_app/assets/icons/logo_icon.dart';
import 'package:customer_app/router/router.dart';
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

    RouterContext router = RouterContext(context);

    // TODO: get user from local storage

    Future.delayed(const Duration(seconds: 3), () {
      router.goTo('Login');
    });
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
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoIcon(
                      fill: CustomColors.secondary,
                      width: 175,
                      height: 175,
                    ),
                    LoadingSpinner(),
                    SizedBox(height: 25),
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
