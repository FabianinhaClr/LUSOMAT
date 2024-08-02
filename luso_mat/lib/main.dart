import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oficial_lusomat/database/dao/questaodao.dart';
import 'package:oficial_lusomat/model/questoes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/telainicial.dart';

Future<void> main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;

  Questao SJISDJ =
      Questao(questao: 'hduif', materia: 'português', ano: 454, resposta: 'd');

  insertQuestao(SJISDJ);

  Questao SJISDD =
      Questao(questao: 'hduif', materia: 'matemática', ano: 454, resposta: 'a');

  insertQuestao(SJISDD);

  List dados = await findall();
  debugPrint(dados.toString());

  runApp(MaterialApp(home: MyApp()));
}
