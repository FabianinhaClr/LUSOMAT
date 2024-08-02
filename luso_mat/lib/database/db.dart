import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> getDatabase() async {
  String caminhoBanco = join(await getDatabasesPath(), 'questoes.db');

  return openDatabase(
    caminhoBanco,
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE questao(id INTEGER PRIMARY KEY, questao TEXT,  materia TEXT, ano INTEGER)');
    },
  );
}
