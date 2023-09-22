import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crudflutter/pages/lista.dart';
import 'package:crudflutter/models.dart';

class DBHelper {
  static DBHelper? _instance;
  late Database _database;

  init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "banco.db"),
      version: 1,
      onCreate: (db, version) async {
        db.execute("""
          CREATE TABLE contatos (
            id INTEGER PRIMARY KEY,
            nome TEXT,
            telefone TEXT
          )
        """);
      },
    ) as Database;
  }

  static Future<DBHelper> getInstance() async{
    if (_instance == null){
        _instance = DBHelper();
        await _instance?.init();
    }
    return _instance!;
  }

  Future<List<Contato>> getAllContatos() async {
    List<Map<String, Object?>> rows = await _database.query('contatos');
    List<Contato> contatos = List.empty();

    for (var element in rows) {
      contatos.add(Contato(
        id: element["id"] as int,
        nome: element["nome"] as String,
        telefone: element["telefone"] as String));
    }

    return contatos;
    
  }
}