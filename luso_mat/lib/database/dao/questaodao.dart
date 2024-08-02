import 'package:flutter/material.dart';
import 'package:oficial_lusomat/model/questoes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../db.dart';

Future<int> insertQuestao(Questao questao) async {
  Database db = await getDatabase();
  return db.insert('questao', questao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map>> findall() async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados = await db.query(
    'questao',
    where: "materia IN (?, ?)",
    whereArgs: ['português', 'matemática'],
  );

  dados.forEach((Questao) {
    print(Questao);
  });

  return dados;
}
