abstract class Animal {
  String nome;
  double peso;
  String cor;
  String raca;
  int idade;


  Animal(this.nome, this.peso, this.cor, this.raca, this.idade);

  void andar() {
    print(
        "o animal $nome esta andando, ele tem $peso kilos, tem a cor $cor e sua idade é de $idade anos...");
  }

  void comer() {
    print("o animal esta comendo");
  }

  void dormir(){
    print("O $nome está dormindo agora...");
  }



}
