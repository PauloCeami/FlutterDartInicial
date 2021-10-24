import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

var request =
    Uri.parse('https://api.hgbrasil.com/finance?format=json&key=d3bdb94b');
double _dolar = 0.0;
double _euro = 0.0;

const MOEDA_REAL = "REAL";
const MOEDA_EURO = "EURO";
const MOEDA_DOLAR = "DOLAR";

final _mControllerReais = TextEditingController();
final _mControllerDolar = TextEditingController();
final _mControllerEuro = TextEditingController();

void main() async {
  runApp(
    MaterialApp(
      title: "App Conversor Finance",
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados...",
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                _dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                _euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 130.0,
                        color: Colors.amber,
                      ),
                      Divider(),
                      criarFieldTextNumber(
                          "Reais", "R\$", _mControllerReais, MOEDA_REAL),
                      Divider(),
                      criarFieldTextNumber(
                          "DOLAR", "US\$", _mControllerDolar, MOEDA_DOLAR),
                      Divider(),
                      criarFieldTextNumber(
                          "Euros", "€", _mControllerEuro, MOEDA_EURO),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Future<Map> getData() async {
  var response = await http.get(request);
  print(convert.jsonDecode(response.body)["results"]["currencies"]["USD"]);
  return convert.jsonDecode(response.body);
}

void _clearAll() {
  _mControllerReais.text = "";
  _mControllerDolar.text = "";
  _mControllerEuro.text = "";
}

Widget criarFieldTextNumber(String labelText, String prefixText,
    TextEditingController c, String TIPO_MOEDA) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefix: Text(prefixText),
    ),
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25.0,
    ),
    onChanged: (text) {
      switch (TIPO_MOEDA) {
        case "EURO":
          if (text.isEmpty) {
            _clearAll();
            return;
          }
          double euro = double.parse(text);
          _mControllerReais.text = (euro * _euro).toStringAsFixed(2);
          _mControllerDolar.text = (euro * _euro / _dolar).toStringAsFixed(2);

          break;
        case "DOLAR":
          if (text.isEmpty) {
            _clearAll();
            return;
          }
          double dolar = double.parse(text);
          _mControllerReais.text = (dolar * _dolar).toStringAsFixed(2);
          _mControllerEuro.text = (dolar * _dolar / _euro).toStringAsFixed(2);

          break;
        case "REAL":
          if (text.isEmpty) {
            _clearAll();
            return;
          }

          double real = double.parse(text);
          _mControllerDolar.text = (real / _dolar).toStringAsFixed(2);
          _mControllerEuro.text = (real / _euro).toStringAsFixed(2);

          break;
      }

      print('Texto do campo: $labelText  $text');
    },
    //keyboardType: TextInputType.numberWithOptions(decimal: true)  para ios
    //Desta forma você poderá digitar números decimais no iOS também!
    keyboardType: TextInputType.number,
  );
}
