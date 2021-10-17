/*
NÃO FAZ SENTIDO INSTANCIAR OBJETOS DESSA CLASSE, uma vez que
qualquer pessoa tem os atributos que aqui estão
MAS PODE SER USADA NA HERANÇA DE OUTRAS PESSOAS DO TIPO CLIENTE, REPRESENTANTE ETC

Ex:
class Advogado extends Pessoa{
  // atributos que são especificos do médico
  String numeroOAB;
  bool isSuperiorCompleto;
}
 */

abstract class Pessoa {
  String nome;
  String telefone;
  String endereco;
  int idade;

  Pessoa(this.nome, this.telefone, this.endereco, this.idade);

  // este metodo será obrigatorio ser implementado na classe que a herdar
  void trabalhar();

  // este metodo será obrigatorio ser implementado na classe que a herdar
  void andarDeCarro();

  // este metodo será obrigatorio ser implementado na classe que a herdar
  void dormir();
}
