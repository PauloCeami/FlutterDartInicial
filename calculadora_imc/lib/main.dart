import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String mInfoText = "informe os seus dados";

  TextEditingController mPeso = TextEditingController();
  TextEditingController mAltura = TextEditingController();
  GlobalKey<FormState> mFormGk_imc = GlobalKey<FormState>();

  void _resetField() {
    setState(() {
      mPeso.text = "";
      mAltura.text = "";
      mInfoText = "informe os seus dados";
    });
  }

  void _calcular() {
    setState(() {
      double ps = double.parse(mAltura.text);
      double alt = double.parse(mPeso.text) / 100;

      double imc = 0.0;
      imc = ps / (alt * alt);
      if (imc < 18.5) {
        mInfoText = "Magreza : ${imc.toStringAsPrecision(4)} ";
      }
      if (imc >= 18.5 && imc <= 24.9) {
        mInfoText = "Peso Normal :  ${imc.toStringAsPrecision(4)} ";
      }
      if (imc >= 24.9 && imc <= 30.0) {
        mInfoText = "Sobrepeso :  ${imc.toStringAsPrecision(4)} ";
      }
      if (imc > 30) {
        mInfoText = "Obesidade :  ${imc.toStringAsPrecision(4)} ";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetField,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: mFormGk_imc,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                size: 100.0,
                color: Colors.green,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Peso";
                  }
                },
                controller: mPeso,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso(Kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(width: 100, height: 15),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua altura";
                  }
                },
                controller: mAltura,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura(cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(width: 100, height: 15),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  // defini a altra do filho botao ElevateButton
                  child: ElevatedButton(
                    onPressed: () {
                      // virifica se o form está com fields preenchidos
                      if (mFormGk_imc.currentState!.validate()) {
                        _calcular();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        )),
                  ),
                ),
              ),
              SizedBox(width: 100, height: 15),
              Text(
                mInfoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(width: 100, height: 15),
              Text(
                "O que é IMC?   IMC significa Índice de Massa Corporal e é um parâmetro utilizado para saber se o peso está de acordo com a altura, o que pode interferir diretamente na saúde e qualidade de vida da pessoa. Assim, a partir do resultado do IMC é possível saber também se a pessoa está dentro do peso ideal e também identificar sobrepeso, obesidade ou desnutrição em crianças, adolescentes, adultos ou idosos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
