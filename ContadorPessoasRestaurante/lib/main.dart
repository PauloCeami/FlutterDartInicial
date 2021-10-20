import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: 'Contador de Pessoas',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _increment = 0;
  String mTextInfo = "Você pode entrar no restaurante...";

  void _incrementar(int delta) {
    setState(() {
      _increment += delta;

      if (_increment <= 0) {
        mTextInfo = "O restaurante está fechado...";
      }
      if (_increment > 5) {
        mTextInfo = "O restaurante tem $_increment pessoas";
      } else {
        mTextInfo = "Você pode entrar no restaurante...";
      }
      if (_increment >= 11) {
        mTextInfo = "O restaurante está fechado";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/restaurante.jpg",
          // preenchendo toda a tela com boxfit https://api.flutter.dev/flutter/painting/BoxFit-class.html
          fit: BoxFit.cover,
          height: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pessoas: $_increment",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint("+1");
                        _incrementar(1);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 10))),
                      child: Text(
                        "+1",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint("-1");
                        _incrementar(-1);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 10))),
                      child: Text(
                        "-1",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ))
              ],
            ),
            Text(
              mTextInfo,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          ],
        )
      ],
    );
  }
}
