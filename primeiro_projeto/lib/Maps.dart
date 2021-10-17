import 'package:primeiro_projeto/Advogado.dart';

void main() {
  Map<int, String> dds = Map();
  dds[16] = "Ribeirão Preto";
  dds[34] = "Minas Gerais";
  dds[81] = "Piauí";

  print("*******************");
  print("KEYS VALUES FOR DDDs ");
  print("DDDs : " + dds.toString());
  print("KEYS : " + dds.keys.toString());
  print("VALUES " + dds.values.toString());
  print("*******************");

  Map<String, dynamic> pessoas = Map();
  pessoas["nome"] = "Enzo";
  pessoas["idade"] = 10;
  pessoas["altura"] = 1.89;

  print("*******************");
  print("KEYS VALUES FOR PESSOAS ");
  print("PESSOAS : " + pessoas.toString());
  print("KEYS : " + pessoas.keys.toString());
  print("VALUES " + pessoas.values.toString());
  print("*******************");

  Map<int, Advodago> info = Map();
  info[1] = Advodago("Joao", "012", "rua das flores", 38, "0158");
  info[2] = Advodago("Pedro", "044", "rua das lirios", 45, "4448");
  info[3] = Advodago("Joao", "019", "rua das rosas", 50, "568758");

  print("*******************");
  print("KEYS VALUES FOR INFO ");
  print(info.remove(1));
  print("INFO : " + info.toString());
  print("KEYS : " + info.keys.toString());
  print("VALUES " + info.values.toString());
  print("*******************");
}
