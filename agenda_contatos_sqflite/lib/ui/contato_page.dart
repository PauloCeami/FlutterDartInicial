import 'package:agenda_contatos_sqflite/model/contato.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  Contato? mContato;

  ContatoPage({this.mContato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  TextEditingController _mNomeController = TextEditingController();
  TextEditingController _mEmailController = TextEditingController();
  TextEditingController _mTelefoneControler = TextEditingController();

  Contato? _edit;

  @override
  void initState() {
    //
    // acessando o parametro do construtor em ContatoPage({this.mContato})
    if (widget.mContato == null) {
      _edit = Contato();
    } else {
      _edit = Contato.fromMap(widget.mContato!.toMap());

      _mNomeController.text = _edit!.nome!;
      _mTelefoneControler.text = _edit!.telefone!;
      _mEmailController.text = _edit!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_edit!.nome ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("images/person.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            inputs()
          ],
        ),
      ),
    );
  }

  Column inputs() {
    return Column(
      children: [
        TextField(
          controller: _mNomeController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: "Nome.:"),
          onChanged: (mText) {
            setState(() {
              if (mText.length > 0) {
                _edit!.nome = mText;
              } else {
                _edit!.nome = "Novo Contato";
              }
            });
          },
        ),
        TextField(
          controller: _mEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: "Email.:"),
          onChanged: (test) {},
        ),
        TextField(
          maxLength: 11,
          controller: _mTelefoneControler,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: "Telefone.:"),
          onChanged: (test) {},
        ),
      ],
    );
  }
}
