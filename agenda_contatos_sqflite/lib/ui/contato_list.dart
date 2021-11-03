import 'dart:io';

import 'package:agenda_contatos_sqflite/Dao/contato_dao.dart';
import 'package:agenda_contatos_sqflite/model/contato.dart';
import 'package:agenda_contatos_sqflite/ui/contato_form.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContatoList extends StatefulWidget {
  const ContatoList({Key? key}) : super(key: key);

  @override
  _ContatoListState createState() => _ContatoListState();
}

class _ContatoListState extends State<ContatoList> {
  List<Contato> mListContatos = [];
  late ContatoDao cDao;

  final ButtonStyle mElevatedButtonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 15,
    ),
  );

  @override
  initState() {
    cDao = ContatoDao();
    super.initState();
    print("::::::::::::::::::::initState called:::::::::::::::::");
    getContatos();
  }

  void getContatos() {
    cDao.getAllContatos().then((list) {
      setState(() {
        mListContatos = list;
      });
    });
  }

  Widget _itemCard(
      BuildContext context, int index, List<Contato> mListContatos) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              getContatoImage(index),
              getDataUser(index),
            ],
          ),
        ),
      ),
      onTap: () {
        Contato c = mListContatos[index];
        if (c != null) {
          _showOptions(context, index, c);
        }
      },
    );
  }

  Padding getDataUser(int index) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            mListContatos[index].nome ?? "",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          Text(
            mListContatos[index].email ?? "",
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            mListContatos[index].telefone ?? "",
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }

  void _showFomContato({Contato? contato}) async {
    final popContato = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContatoForm(
          mContato: contato,
        ),
      ),
    );

    if (popContato != null) {
      print("CONTATO EDITADO " + popContato.toString());
    } else {
      print("CONTATO CADASTRADO " + popContato.toString());
    }
    getContatos();
  }

  Container getContatoImage(index) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: mListContatos[index]!.img != null
              ? FileImage(File(mListContatos[index]!.img.toString()))
              : AssetImage("images/person.png") as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Contatos"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          _showFomContato();
        },
      ),
      body: ListView.builder(
          itemCount: mListContatos.length,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            return _itemCard(
              context,
              index,
              mListContatos,
            );
          }),
    );
  }

  void _showOptions(BuildContext context, int index, Contato c) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      launch("tel:${c.telefone}");
                      Navigator.pop(context);
                    },
                    child: Text("LIGAR"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showFomContato(contato: c);
                    },
                    child: Text("EDITAR"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cDao.deleteContact(c.id).then((value) {
                        print("PRINTANTO DO VALUE DO DELETE : " +
                            value.toString());
                        setState(() {
                          mListContatos.removeAt(index);
                          Navigator.pop(context);
                        });
                      });
                    },
                    child: Text("EXCLUIR"),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
