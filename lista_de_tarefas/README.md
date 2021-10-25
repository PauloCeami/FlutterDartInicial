# lista_de_tarefas

aplicativo de persistencia de tarefas

SALVANDO ARQUIVOS NO FORMATO data.json dentro do device

 void _addTarefa() {
    setState(() {
      Map<String, dynamic> todo = Map();
      todo['title'] = _mTarefaController.text;
      todo['ok'] = false;
      _mTarefaController.text = "";
      _todoList.add(todo);

      _saveData(); // salvando dados em arquivo dentro do device
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



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
