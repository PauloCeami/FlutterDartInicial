import 'package:primeiro_projeto/Animal.dart';

class Cachorro extends Animal {
  int fofura;

  Cachorro(
      String nome, double peso, String cor, String raca, int idade, this.fofura)
      : super(nome, peso, cor, raca, idade);

  void latir() {
    print("o cachorro esta latindo");
  }

  void brincar() {
    fofura += 10;
    print(
        "A fofura do cachorrinho $nome aumentou $fofura, e ele está muito dócil hoje...");
  }

  @override
  void dormir() {
    print("O $nome não está dormindo agora...");
  }

  @override
  String toString() {
    return " Dados do Cachorro  | Nome: $nome , Peso: $peso, Cor: $cor, Raca: $raca, Idade: $idade";
  }
}
