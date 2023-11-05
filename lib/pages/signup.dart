import 'package:customer_app/data/types.dart';
import 'package:customer_app/services/customer.dart';
import 'package:customer_app/templates/non_auth.dart';
import 'package:customer_app/ui/components/loading_spinner.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:customer_app/ui/layouts/text_input.dart';
import 'package:customer_app/router/router.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signup(context) async {
    setState(() {
      isLoading = true;
    });

    Response response = await CustomerService().signup(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (response.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: CustomColors.error,
        ),
      );
    } else {
      RouterContext router = RouterContext(context);
      router.goTo('Login');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NonAuthTemplate(
      currentPage: 'Signup',
      form: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextInput(name: 'name', labelText: 'Nome', controller: _nameController),
                Container(padding: const EdgeInsets.all(10)),
                TextInput(name: 'email', labelText: 'Email', controller: _emailController),
                Container(padding: const EdgeInsets.all(10)),
                TextInput(name: 'password', labelText: 'Senha', controller: _passwordController, isSecret: true),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(children: [
            Expanded(
              child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(CustomColors.secondary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 19)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      signup(context);
                    }
                  },
                  child: !isLoading
                      ? const Text('Cadastrar', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
                      : LoadingSpinner(
                          size: 25,
                        )),
            ),
          ]),
        ],
      ),
    );
  }
}
