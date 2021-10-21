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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person,
              size: 100.0,
              color: Colors.green,
            ),
            TextField(
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
            TextField(
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
                  onPressed: () {},
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.green,
                      )),
                ),
              ),
            ),
            SizedBox(width: 100, height: 15),
            Text(
              "Info :",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
