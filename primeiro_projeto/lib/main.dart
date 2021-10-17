import 'package:primeiro_projeto/Animal.dart';
import 'package:primeiro_projeto/Cachorro.dart';
import 'package:primeiro_projeto/Gato.dart';
import 'package:primeiro_projeto/StaticFinalConst.dart';

const String MINHA_CONSTANT =
    "ESTÁ É UMA CONSTANTE DART QUE GUARDA UM VALOR IMUTÁVEL";

void main() {
  Cachorro dog = new Cachorro('Tom', 10, 'Preto', 'vira lata', 5, 2);

  dog.andar();
  dog.brincar();
  dog.dormir();

  print(dog);

  Gato cat = new Gato('Tiulli', 2, 'branco', 'angorá', 3);
  cat.miar();

  print(cat);


  String projeto = MINHA_CONSTANT;


  // classe StaticFinalConst
  StaticFinalConst.Contador += 3;

  StaticFinalConst.NUMBER_STATIC; // constant

  // classes abstradas não podem ser instanciadas
  // a classe animal não faz sentido ser instanciada sozinha
  /*
  Abstract classes can't be instantiated. (Documentation)  Try creating an instance of a concrete subtype.
   */
  Animal anim = new Animal();
}
