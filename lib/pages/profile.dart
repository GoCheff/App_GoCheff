import 'package:customer_app/states/user.dart';
import 'package:customer_app/templates/auth.dart';
import 'package:customer_app/ui/data/custom_colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      currentRoute: 'Profile',
      title: "Perfil",
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white, // Cor de fundo do contêiner
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF393939).withOpacity(0.03), // Cor e opacidade do boxShadow
                      offset: Offset(0, 30), // Deslocamento horizontal (0) e vertical (30)
                      blurRadius: 60, // Raio de desfoque
                      spreadRadius: 0, // Espalhamento
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
                      // child: Image.asset('caminho_para_sua_imagem.jpg'),
                    ),
                    SizedBox(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            watchUserState(context)?.name ?? "",
                            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Cor de fundo do contêiner
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF393939).withOpacity(0.03), // Cor e opacidade do boxShadow
                      offset: Offset(0, 30), // Deslocamento horizontal (0) e vertical (30)
                      blurRadius: 60, // Raio de desfoque
                      spreadRadius: 0, // Espalhamento
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pedidos",
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: CustomColors.black,
                      size: 20.0,
                    ),
                  ],
                ),
              ),

              // Espaçamento entre o conteúdo e os botões
              SizedBox(height: 20),

              // Botões "Atualizar" e "Sair" ocupando a largura total
              ElevatedButton(
                onPressed: () {
                  // Lógica para a ação "Atualizar"
                },
                style: ElevatedButton.styleFrom(
                  primary: CustomColors.secondary, // Cor de fundo do botão
                  minimumSize: Size(double.infinity, 48), // Largura total e altura do botão
                ),
                child: Text("Atualizar"),
              ),
              SizedBox(height: 10), // Espaçamento entre os botões
              ElevatedButton(
                onPressed: () {
                  // Lógica para a ação "Sair"
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Cor de fundo do botão
                  minimumSize: Size(double.infinity, 48), // Largura total e altura do botão
                ),
                child: Text("Sair"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
