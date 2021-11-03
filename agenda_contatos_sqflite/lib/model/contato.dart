final String idColumn = "id";
final String nomeColumn = "nome";
final String emailColumn = "email";
final String telefoneColumn = "telefone";
final String imgColumn = "img";

/*
String myVar = ' '; <- atribui um valor desde o início, o null-safety nunca vai reclamar dessa variável pq ela nunca poderá ser nula.
late String myVar; <- para o null-safety, é o mesmo caso do acima, pois quando a variável é late vc está garantindo ao Flutter que irá preencher algum valor na variável antes de usar ela.
String? myVar; <- nessa caso você está dizendo ao Flutter que pretende salvar null na variável em algum momento, e por isso o null-safety vai exigir que vc faça as validações com o ! ou ? toda hora.
 */
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
