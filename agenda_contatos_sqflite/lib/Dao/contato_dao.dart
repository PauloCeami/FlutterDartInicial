import 'package:agenda_contatos_sqflite/model/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

const String tableContato = "contato";

const String sqlContato =
    "CREATE TABLE [$tableContato] ($idColumn  INTEGER PRIMARY KEY AUTOINCREMENT , $nomeColumn VARCHAR DEFAULT 100 , $emailColumn VARCHAR DEFAULT 100, $telefoneColumn VARCHAR DEFAULT 100 ,$imgColumn VARCHAR DEFAULT 100)";

const String sqlCliente =
    "CREATE TABLE [CLIENTES] (cli_codigo INTEGER ,cli_nome VARCHAR DEFAULT 50,cli_fantasia VARCHAR DEFAULT 50,cli_endereco VARCHAR DEFAULT 50,cli_bairro  VARCHAR DEFAULT 50,cli_cep VARCHAR DEFAULT 50,cid_codigo INTEGER,cli_contato1 VARCHAR DEFAULT 50,cli_contato2 VARCHAR DEFAULT 50,cli_contato3 VARCHAR DEFAULT 50,cli_nascimento DATE,  cli_cpfcnpj  VARCHAR DEFAULT 50,  cli_rginscricaoest VARCHAR DEFAULT 50,  cli_limite DECIMAL(10,2),  cli_email  VARCHAR DEFAULT 50,  cli_observacao  VARCHAR DEFAULT 50 ,  usu_codigo  INTEGER,  cli_enviado VARCHAR DEFAULT 20,  cli_senha   VARCHAR DEFAULT 60 ,cli_chave VARCHAR DEFAULT 100 )";

const String idColumn = "id";
const String nomeColumn = "nome";
const String emailColumn = "email";
const String telefoneColumn = "telefone";
const String imgColumn = "img";

class ContatoDao {
  // singleton pattern
  static final ContatoDao _instance = ContatoDao.internal();

  factory ContatoDao() => _instance;

  ContatoDao.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contato.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(sqlContato);
      await db.execute(sqlCliente);
    });
  }

  Future<int> save(Contato c) async {
    Database? dbContato = await db;
    int id = await dbContato!.insert(tableContato, c.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("::: CONTATO LAST ID INSERT : $id");
    return id;
  }

  Future<Contato?> update(Contato c) async {
    Database? dbContact = await db;
    int id = await dbContact!.update(tableContato, c.toMap(),
        where: "$idColumn = ?",
        whereArgs: [c.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    Contato? contato = await getContato(id);
    print("::: CONTATO INSERIDO INSERT : " + contato.toString());
    return await contato;
  }

  Future<Contato?> getContato(int id) async {
    Database? dbContato = await db;
    List<Map<String, dynamic>> maps = await dbContato!.query(tableContato,
        columns: [idColumn, nomeColumn, emailColumn, telefoneColumn, imgColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      print("::: CONTATO JSON : " + maps.first.toString());
      return Contato.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int? id) async {
    Database? dbContato = await db;
    return await dbContato!
        .delete(tableContato, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<List<Contato>> getAllContatos() async {
    Database? dbContact = await db;
    List listMap = await dbContact!.rawQuery("SELECT * FROM $tableContato");
    print("::: CONTATO LIST JSON : " + listMap.toString());
    List<Contato> listContact = [];
    for (Map m in listMap) {
      listContact.add(Contato.fromMap(m));
    }
    return listContact;
  }

  Future<int?> getNumber() async {
    Database? dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact!.rawQuery("SELECT COUNT(*) FROM $tableContato"));
  }

  Future close() async {
    Database? dbContact = await db;
    dbContact!.close();
  }
}
