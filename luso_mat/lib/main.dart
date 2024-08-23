import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oficial_lusomat/database/dao/questaodao.dart';
import 'package:oficial_lusomat/model/questao.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/telainicial.dart';

Future<void> main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;

  insertTodasQuestao();

  List dados = await findall();
  debugPrint(dados.toString());

  runApp(MaterialApp(home: MyApp()));
}






