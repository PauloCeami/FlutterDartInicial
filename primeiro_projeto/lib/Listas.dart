import 'package:primeiro_projeto/Advogado.dart';
import 'package:primeiro_projeto/ClasseAbstrata.dart';
import 'package:primeiro_projeto/Medico.dart';

void main() {
  // lista de nomes
  List<String> nomes = ['pedro', 'eliseu', 'gisele', 'paulo'];
  print("**********************");
  print("listando o primeiro do indice 0...");
  print(nomes[0]);
  print("**********************");
  print("adicionando Valdeir e mostrando todos da lista");
  nomes.add("valdeir");
  print(nomes);
  print("**********************");
  print("mostrando o tamanho da lista");
  print(nomes.length);
  print("**********************");
  print("removendo o indice 2 =  gisele, e mostrando todos");
  nomes.removeAt(2);
  print(nomes);
  print("**********************");
  print("inserindo maria no indice 1 que é depois do pedro");
  nomes.insert(1, "Maria");
  print(nomes);
  print("**********************");
  print(
      "verificando se existe um nome na lista, case Sensitive maria != Maria");
  print(nomes.contains("Maria"));

  List<Medico> medico = [];

  medico.add(Medico("Marcelo Pimentel", "034 99522 5588", "Rua dos lirios 358",
      25, "025855225-55",
      isSuperiorCompleto: true));

  medico.add(Medico("Claudia Hohana", "034 98566 0011", "Rua das flores 1500",
      37, "258833300-X55",
      isSuperiorCompleto: false));

  medico.add(Medico(
      "Vanessa Félix", "034 99977 569", "Rua das rosas 10", 37, "05510",
      isSuperiorCompleto: false));

  for (Medico p in medico) {
    print("**************");
    print("Nome : " + p.nome);
    print("Contato : " + p.telefone);
    print("CRM : " + p.CRM);
    print("**************");
  }
}
