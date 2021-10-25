import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  List _todoList = [];

  final _mTarefaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /*
                TextFieldexpande-se na direção horizontal e o mesmo acontece com o Row,
                portanto, precisamos restringir a largura do TextField, há muitas maneiras de fazer isso.
                 Usar Expanded

                 Row(
                  children: <Widget>[
                    Expanded(child: TextField()),
                    // more widgets
                  ],
                )
                Usar Flexible

                Row(
                  children: <Widget>[
                    Flexible(child: TextField()),
                    // more widgets
                  ],
                )
                Embrulhe em Container ou SizedBoxe forneçawidth

                Row(
                  children: <Widget>[
                    SizedBox(width: 100, child: TextField()),
                    // more widgets
                  ],
                )
                 */
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.60, // pega 60% da tela
                  child: TextField(
                    controller: _mTarefaController,
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                // SizedBox(width: 18.0), // espaço entre o botao e field
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.30, // pega 30% da tela dentro
                  child: ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: _addTarefa,
                    child: Text('Add Tarefa'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshOrder,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _todoList.length,
                itemBuilder: buildItem,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      key: UniqueKey(),
      child: CheckboxListTile(
        title: Text(_todoList[index]['title']),
        value: _todoList[index]['ok'],
        secondary: CircleAvatar(
          child: Icon(_todoList[index]['ok'] ? Icons.check : Icons.error),
        ),
        onChanged: (boleanCheck) {
          setState(() {
            // boleanCheck = true ou false
            _todoList[index]['ok'] = boleanCheck;
            _saveData();
          });
        },
      ),

      // função chamada ao deslizar o componente na tela
      onDismissed: (direction) {
        // repassando um List para um Map temporario
        Map<String, dynamic> _lastTarefaRemoved = Map.from(_todoList[index]);

        // pegando a posicao real em que a tarefa estava
        int _lastTarefaPosition = index;

        // removendo a tarefa da lista
        _todoList.removeAt(index);

        // atualizando o file arqruivo no device sem a tarefa que foi excluida
        _saveData();

        final snack = SnackBar(
          content:
              Text("Tarefa \" ${_lastTarefaRemoved["title"]} \"  removida "),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() {
                // ao desfazer então inserimos a tarefa na lista novamente na posição em que ela já estava
                _todoList.insert(_lastTarefaPosition, _lastTarefaRemoved);

                // salvando a tarefa novamente no FILE
                _saveData();
              });
            },
          ),
          duration: Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
    );
  }

  Future<Null> _refreshOrder() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _todoList.sort((a, b) {
        if (a["ok"] && !b["ok"]) {
          return 1;
        }
        if (!a["ok"] && b["ok"]) {
          return -1;
        }
        return 0;
      });
    });

    return null;
  }

  void _addTarefa() {
    setState(() {
      if (_mTarefaController.text.isNotEmpty) {
        Map<String, dynamic> todo = Map();
        todo['title'] = _mTarefaController.text;
        todo['ok'] = false;
        _mTarefaController.text = "";
        _todoList.add(todo);

        _saveData(); // salvando dados em arquivo dentro do device
      }
    });
  }

  Future<File> _getFile() async {
    // cria ou pega o arquivo no device
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    // salva dos dados de map e transforma ele em uma string json
    //[{title: estudar java, ok: true}, {title: criar parametro na classe, ok: false}]
    String data = json.encode(_todoList);

    // pega o arquivo no device
    final file = await _getFile();

    // escreve e salva os dados json nele
    return file.writeAsString(data);
  }

  Future<String?> _readData() async {
    try {
      //PEGA O arquivo no device  '/data/user/0/br.com.tarefas.app.lista_de_tarefas/app_flutter/data.json'
      final file = await _getFile();

      // le o arquivo e devolve uma string -> [{title: estudar java, ok: true}, {title: criar parametro na classe, ok: false}]
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    // lendo os dados em String json e colocando dentro do Map novamente
    //[{title: estudar java, ok: true}, {title: criar parametro na classe, ok: false}]
    _readData().then((data) {
      setState(() {
        _todoList = json.decode(data!);
        print(_todoList);
      });
    });
  }
}
