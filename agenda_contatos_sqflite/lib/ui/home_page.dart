import 'package:agenda_contatos_sqflite/Dao/contato_dao.dart';
import 'package:agenda_contatos_sqflite/model/contato.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contato> mListContatos = [];

  @override
  void initState() {
    setState(() {
      ContatoDao cDao = new ContatoDao();

      cDao.getAllContatos().then((list) {
        mListContatos = list;
      });
    });
  }

  Widget _itemCard(context, index) {
    return GestureDetector(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: mListContatos[index].img != null
                          ? AssetImage("images/person.png")
                          : AssetImage("images/person.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mListContatos[index].nome ?? "",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        mListContatos[index].email ?? "",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        mListContatos[index].telefone ?? "",
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {});
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
        onPressed: () {},
      ),
      body: ListView.builder(
          itemCount: mListContatos.length,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            return _itemCard(context, index);
          }),
    );
  }
}
