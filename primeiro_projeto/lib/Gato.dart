import 'package:primeiro_projeto/Animal.dart';

class Gato extends Animal {
  Gato(String nome, double peso, String cor, String raca, int idade)
      : super(nome, peso, cor, raca, idade);

  void miar() {
    print("o gato esta miando...");
  }



  @override
  String toString() {
    return " Dados do Gato  | Nome: $nome , Peso: $peso, Cor: $cor, Raca: $raca, Idade: $idade";
  }

  @override
  void dormir() {
   print("O gato está dormindo agora...");
  }
}
