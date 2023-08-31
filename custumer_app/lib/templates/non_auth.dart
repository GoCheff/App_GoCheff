import 'package:customer_app/ui/components/icon.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/material.dart';

class NonAuthTemplate extends StatefulWidget {
  final Widget form;

  const NonAuthTemplate({super.key, required this.form});

  @override
  _NonAuthTemplateState createState() => _NonAuthTemplateState();
}

class _NonAuthTemplateState extends State<NonAuthTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white.withOpacity(0.93),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: 500,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: CustomColors.white,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [IconWidget(name: 'logo', size: 200)],
              ),
            ),
            Container(
              height: 50,
              width: 500,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 75.75),
              decoration: const BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLoginButton(context),
                  _buildRegisterButton(context),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: widget.form,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 4, color: CustomColors.secondary)),
      ),
      child: TextButton(
        style: ElevatedButton.styleFrom(backgroundColor: CustomColors.white),
        onPressed: () {
        },
        child: const Text(
          'Entrar',
          style: TextStyle(color: CustomColors.black),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.white,
      ),
      onPressed: () {
        // TODO: Lógica para redirecionar para a tela de registro
      },
      child:
          const Text('Cadastrar', style: TextStyle(color: CustomColors.black)),
    );
  }
}
