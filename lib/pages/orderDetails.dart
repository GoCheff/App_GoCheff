import 'package:flutter/material.dart';
import 'package:customer_app/ui/data/custom_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Header(),
            OrderSquare(),

            Expanded(
              child: Container(),
            ),

            MyValueRow(
              label: 'Total:',
              value: '120.00',
            ),
            OrderButtom(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: CustomColors.quaternary,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 25,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: Center(
              child: Text(
                'Pedido',
                style: TextStyle(
                  fontSize: 20.0,
                  color: CustomColors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
    );
  }
}

class OrderSquare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      'Lorem ipsum',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: CustomColors.black,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum.'),
                    ),
                    SizedBox(height: 16.0),
                    Text('+12 223456789'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyValueRow extends StatelessWidget {
  final String label;
  final String value;

  MyValueRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
              label, style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class OrderButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.secondary,
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          'Enviar pedido para o chefe', // Texto do botão
          style: TextStyle(
            fontSize:15.0,
          ),
        ),
      ),
    );
  }
}
