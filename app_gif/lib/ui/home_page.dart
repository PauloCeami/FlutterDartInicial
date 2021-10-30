import 'dart:convert' as convert;

import 'package:app_gif/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search = "";
  int _offset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(color: Colors.white, fontSize: 15.0),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pesquisar pelos gatos do márcio",
                labelStyle: TextStyle(color: Colors.white),
              ),
              onSubmitted: _submited,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                // testando o estado da conexao do device
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      height: 200.0,
                      width: 200.0,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return _getGridGifs(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _getData().then((map) => print(map));
  }

  Widget _getGridGifs(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: getListData(snapshot.data["data"]),
      itemBuilder: (context, index) {
        //
        int tamanho_lista = snapshot.data["data"].length;

        // se nao for o ultimo item da lista
        if (_search == "" || index < tamanho_lista) {
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              height: 300.0,
              fit: BoxFit.cover,
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"],
            ),
            onLongPress: () {
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"]);
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    // enviado o indice do cmo ele é, um Map
                    return GifPage(snapshot.data["data"][index]);
                  },
                ),
              );
            },
          );
        } else {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 70.0,
                  ),
                  Text(
                    "Carregar mais ...",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  )
                ],
              ),
              onLongPress: () {
                Share.share(snapshot.data["data"][index]["images"]
                    ["fixed_height"]["url"]);
              },
              onTap: () {
                setState(() {
                  _offset += 19;
                });
              },
            ),
          );
        }
      },
    );
  }

  Future<Map> _getData() async {
    http.Response response;
    if (_search == null || _search.isEmpty) {
      response = await http.get(Uri.parse(
          'https://api.giphy.com/v1/gifs/trending?api_key=ec2f06jsVDWaQsYCEaMppzFQP0ilPCDK&limit=20&rating=pg-13'));
    } else {
      response = await http.get(Uri.parse(
          'https://api.giphy.com/v1/gifs/search?api_key=ec2f06jsVDWaQsYCEaMppzFQP0ilPCDK&q=$_search&limit=19&offset=$_offset&rating=pg-13&lang=pt'));
    }
    return convert.jsonDecode(response.body);
  }

  int getListData(List data) {
    if (_search == "") {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  void _submited(String value) {
    setState(() {
      _search = value;
      _offset = 0; // ao pesquisar mostra sempre os primeiros 19 itens
    });
  }
}
