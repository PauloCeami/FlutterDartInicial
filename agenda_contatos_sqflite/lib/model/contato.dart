final String idColumn = "id";
final String nomeColumn = "nome";
final String emailColumn = "email";
final String telefoneColumn = "telefone";
final String imgColumn = "img";

class Contato {
  int? id;
  String? nome;
  String? email;
  String? telefone;
  String? img;

  Contato();

  // recuperando dados do bando
  Contato.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    email = map[emailColumn];
    telefone = map[telefoneColumn];
    img = map[imgColumn];
  }

  // repassando dados para o DB em formato map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> cont = Map();
    cont[nomeColumn] = nome;
    cont[emailColumn] = email;
    cont[telefoneColumn] = telefone;
    cont[imgColumn] = img;
    if (id != null) {
      cont[idColumn] = id;
    }
    return cont;
  }

  @override
  String toString() {
    return "Contato: (id:$id, nome:$nome, email:$email, telefone:$telefone, img:$img)";
  }
}
