import 'package:agenda_contatos_sqflite/ui/contato_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: ContatoList(),
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
      ),
    ),
  );
}
