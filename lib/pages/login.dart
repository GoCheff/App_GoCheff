import 'package:customer_app/data/types.dart';
import 'package:customer_app/services/customer.dart';
import 'package:customer_app/templates/non_auth.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:customer_app/ui/layouts/text_input.dart';
import 'package:customer_app/router/router.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    Response response = await CustomerService().login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    print(response.message);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RouterContext router = RouterContext(context);
    _login();

    return NonAuthTemplate(
      form: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextInput(
                    name: 'email',
                    labelText: 'Email',
                    controller: _emailController),
                Container(padding: const EdgeInsets.all(10)),
                TextInput(
                    name: 'password',
                    labelText: 'Senha',
                    controller: _passwordController,
                    isSecret: true),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            children: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: const Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: CustomColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () {
                  router.goTo('Forgot password');
                },
              ),
            ],
          ),
          Row(children: [
            Expanded(
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(CustomColors.secondary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 19)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processando dados')),
                    );
                  }
                },
                child: const Text('Entrar',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
