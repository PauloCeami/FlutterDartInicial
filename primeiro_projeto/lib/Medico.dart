import 'package:primeiro_projeto/ClasseAbstrata.dart';

class Medico extends Pessoa {
  String CRM;
  bool isSuperiorCompleto;

  Medico(String nome, String telefone, String endereco, int idade, this.CRM,
      {this.isSuperiorCompleto = false})
      : super(nome, telefone, endereco, idade);

  void emitirReceita() {
    print("o Médico $nome está emitindo receita...");
  }

  @override
  void andarDeCarro() {
    // TODO: implement andarDeCarro
  }

  @override
  void dormir() {
    // TODO: implement dormir
  }

  @override
  void trabalhar() {
    // TODO: implement trabalhar
  }
}
