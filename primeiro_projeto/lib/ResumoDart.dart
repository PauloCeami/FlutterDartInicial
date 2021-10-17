void main() {
  // Comparadores
  // ----------------------
  // >		maior
  // >=		maior ou igual
  // <		menor
  // <=		menor ou igual
  // ==		igual
  // !=		diferente

  bool testeComp = (10 != 20);

  print("COMP: $testeComp");

  // Operador OR
  // ----------------------
  // true		true 	-> true
  // true		false -> true
  // false	true 	-> true
  // false	false -> false

  bool testeOr = (true || false);

  print("OR: $testeOr");

  // Operador AND
  // ----------------------
  // true		true 	-> true
  // false	false -> false
  // true		false -> false
  // false	true 	-> false

  bool testeAnd = (true && false);

  print("AND: $testeAnd");

  bool complexa = !(10 > 20) && ((30 < 20) || testeAnd);

  print(complexa);

  criarBotao("BotaoCamera", botaoCriado);

  criarBotao("BotaoGaleria", () {
    print("Botao criado!!! (func anonima)");
  });

  criarBotao("BotaoFechar", () {}, cor: "Branco", largura: 20.0);
}

void botaoCriado() {
  print("Botao criado!!!");
}

void criarBotao(String texto, Function criadoFunc,
    {String cor = "", double largura = 0}) {
  print(texto);
  print(cor ?? "Preto");
  print(largura ?? 10.0);
  criadoFunc();
}
