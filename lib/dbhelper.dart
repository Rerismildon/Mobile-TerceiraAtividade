import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper? _instance;

  late Database database;

  init() async {
    database = openDatabase(
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

  static getInstance() async{
    if (_instance == null){
        _instance = DBHelper();
        _instance?.init();
    }
    return _instance!;
  }

  static Future<List<contatos> getAllContatos() async {
    DBHelper helper = await DBHelper.getInstance();

    List<Map<String, Object?>> rows = await helper.database.query('contatos');
    List<Contato> contatos = List.empty();
  }
}