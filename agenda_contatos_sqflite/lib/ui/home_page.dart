import 'package:agenda_contatos_sqflite/Dao/contato_dao.dart';
import 'package:agenda_contatos_sqflite/model/contato.dart';
import 'package:agenda_contatos_sqflite/ui/contato_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contato> mListContatos = [];

  @override
  initState() {
    super.initState();

    setState(() {
      ContatoDao cDao = new ContatoDao();
      cDao.getAllContatos().then((list) {
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
              getContatoImage(),
              getDataUser(index),
            ],
          ),
        ),
      ),
      onTap: () {
        Contato c = mListContatos[index];
        if (c != null) {
          _showContactPage(contact: c);
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

  void _showContactPage({Contato? contact}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContatoPage(
          mContato: contact,
        ),
      ),
    );
  }

  Container getContatoImage() {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage("images/person.png"), fit: BoxFit.cover),
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
          _showContactPage();
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
}
