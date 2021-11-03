import 'dart:io';

import 'package:agenda_contatos_sqflite/Dao/contato_dao.dart';
import 'package:agenda_contatos_sqflite/model/contato.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ContatoForm extends StatefulWidget {
  Contato? mContato;

  ContatoForm({this.mContato});

  @override
  _ContatoFormState createState() => _ContatoFormState();
}

class _ContatoFormState extends State<ContatoForm> {
  TextEditingController mNomeController = TextEditingController();
  TextEditingController mEmailController = TextEditingController();
  TextEditingController mTelefoneControler = TextEditingController();

  Contato? mContatoEditing;
  Contato? mContatoObj;
  late FocusNode mNameFocusNode;
  late FocusNode mEmailfocusNode;
  late FocusNode mTelefoneFocusNode;
  late bool IS_EDIT = false;

  @override
  void initState() {
    // acessando o parametro do construtor em ContatoPage({this.mContato})
    if (widget.mContato == null) {
      IS_EDIT = false;
      mContatoEditing = Contato();
    } else {
      mContatoEditing = Contato.fromMap(widget.mContato!.toMap());
      mNomeController.text = mContatoEditing!.nome!;
      mTelefoneControler.text = mContatoEditing!.telefone!;
      mEmailController.text = mContatoEditing!.email!;
    }

    mNameFocusNode = FocusNode();
    mEmailfocusNode = FocusNode();
    mTelefoneFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(mContatoEditing!.nome ?? "Novo Contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(":::::::::::::::::::::::::::::: save pressed ");

            if (!isFormValid()) {
              return;
            }

            print(":::::::::::::::::::::::::::::: salvando contato");
            saveContato();

            Navigator.pop(context, mContatoObj);
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: mContatoEditing!.img != null
                          ? FileImage(File(mContatoEditing!.img.toString()))
                          : AssetImage("images/person.png") as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              inputs()
            ],
          ),
        ),
      ),
    );
  }

  void saveContato() {
    ContatoDao cd = ContatoDao();
    mContatoObj = Contato();
    mContatoObj!.nome = mNomeController.text;
    mContatoObj!.email = mEmailController.text;
    mContatoObj!.telefone = mTelefoneControler.text;
    mContatoObj!.img = mContatoEditing!.img.toString();

    if (widget.mContato == null) {
      cd.save(mContatoObj!);
    } else {
      mContatoObj!.id = widget.mContato!.id;
      cd.update(mContatoObj!);
    }
  }

  Column inputs() {
    return Column(
      children: [
        TextField(
          autofocus: true,
          focusNode: mNameFocusNode,
          controller: mNomeController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Nome.:',
            hintText: 'digite seu nome',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
          ),
          onChanged: (mText) {
            setState(
              () {
                IS_EDIT = true;
                print("NOME EDITADO ");
                if (mText.length > 0) {
                  mContatoEditing!.nome = mText;
                } else {
                  mContatoEditing!.nome = "Novo Contato";
                }
              },
            );
          },
        ),
        Divider(
          height: 7.0,
        ),
        TextField(
          focusNode: mEmailfocusNode,
          controller: mEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email.:',
            hintText: 'digite seu email',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
          ),
          onChanged: (test) {
            setState(() {
              print("EMAIL EDITADO ");
              IS_EDIT = true;
            });
          },
        ),
        Divider(
          height: 7.0,
        ),
        TextField(
          focusNode: mTelefoneFocusNode,
          controller: mTelefoneControler,
          maxLength: 11,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Telefone.:',
            hintText: 'digite seu telefone',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
          ),
          onChanged: (test) {
            setState(
              () {
                print("TELEFONE EDITADO ");
                IS_EDIT = true;
              },
            );
          },
        ),
      ],
    );
  }

  bool isFormValid() {
    if (mNomeController.text.length <= 0 || mNomeController.text.isEmpty) {
      mNameFocusNode.requestFocus();
      return false;
    }
    if (mEmailController.text.isEmpty || mEmailController.text.length <= 0) {
      mEmailfocusNode.requestFocus();
      return false;
    }
    if (mTelefoneControler.text.isEmpty ||
        mTelefoneControler.text.length <= 0) {
      mTelefoneFocusNode.requestFocus();
      return false;
    }
    return true;
  }

  Future<bool> _requestPop() {
    if (IS_EDIT) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Descartar Alterações?"),
            content: Text("Se sair as alterações serão perdidas."),
            actions: <Widget>[
              ElevatedButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text("Sim"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void dispose() {
    mNameFocusNode.dispose();
    mEmailfocusNode.dispose();
    mTelefoneFocusNode.dispose();
    super.dispose();
  }

  Future pickImage() async {
    try {
      final fileImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (fileImage == null) return;

      final imageTemp = File(fileImage.path);

      setState(() {
        mContatoEditing!.img = imageTemp.path;
      });
    } on PlatformException catch (e) {
      print("error image");
    }
  }
}
