import 'package:customer_app/assets/icons/no_wifi_icon.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Jost',
          primarySwatch: CustomColors.palette,
        ),
        title: 'Go Cheff - sem internet',
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          backgroundColor: CustomColors.background,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NoWifiIcon(width: 80, height: 80, fill: Colors.grey),
                SizedBox(height: 20),
                Text(
                  'Sem internet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Sua conexão com a Internet está atualmente\nnão disponível, verifique ou tente novamente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ));
  }
}
