import 'package:primeiro_projeto/ClasseAbstrata.dart';

class Advodago extends Pessoa {
  String Numero_OAB;
  bool isSuperiorCompleto;

  Advodago(
      String nome, String telefone, String endereco, int idade, this.Numero_OAB,
      {this.isSuperiorCompleto = false})
      : super(nome, telefone, endereco, idade);

  @override
  void andarDeCarro() {
    print("o Advogado $nome está no transito...");
  }

  @override
  void dormir() {
    print("o Advogado $nome está dormindo, agora é hora do almoço...");
  }

  @override
  void trabalhar() {
    print("o Advogado $nome está trabalhando agora...");
  }

  void imprimirProcesso() {
    print("o Advogado $nome está imprimindo processo...");
  }

  @override
  String toString() {
    return "$nome $telefone $endereco $idade $Numero_OAB";
  }
}
