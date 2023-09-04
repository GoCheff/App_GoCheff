import 'package:customer_app/router/router.dart';
import 'package:customer_app/ui/components/no_internet_screen.dart';
import 'package:customer_app/ui/components/splash_screen.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);

    return InternetWidget(
        offline: const FullScreenWidget(
          child: NoInternetScreen(),
        ),
        online: MaterialApp(
          theme: ThemeData(
              primarySwatch: CustomColors.palette, fontFamily: 'Jost'),
          title: 'Go Cheff',
          routes: router.getRoutes(),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
