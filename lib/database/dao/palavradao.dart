import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:triolingo/database/dao/preferenciadao.dart';
import 'package:triolingo/database/db.dart';
import 'package:triolingo/main.dart';

Future<List<Map<String, Object?>>> buscarPares(String linguaPadrao, String linguaDesejada) async {
  Database db = await getDatabase();

  String grafia = 'grafia${linguaDesejada[0].toUpperCase()}${linguaDesejada.substring(1).toLowerCase()}';
  String significado = 'significado${linguaPadrao[0].toUpperCase()}${linguaPadrao.substring(1).toLowerCase()}';

  List<Map<String, Object?>> data = await db.query('palavras', columns: ['idPalavra', grafia, significado]);

  return data;
}

Future<int> cadastrarConhecida(int idPalavra, String linguaPadrao, String linguaDesejada) async {
  Database db = await getDatabase();

  return await db.insert('conhecidas', {'idPalavra': idPalavra, 'linguaPadrao': linguaPadrao, 'linguaEscolhida': linguaDesejada}, conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, Object?>>> buscarConhecidas(String linguaEscolhida) async {
  Database db = await getDatabase();

  String linguaPadrao = (await buscarLingua()).first.values.first.toString();

  Future<List<Map<String, Object?>>> data = db.rawQuery('SELECT palavras.* FROM conhecidas INNER JOIN palavras ON conhecidas.idPalavra = palavras.idPalavra WHERE conhecidas.linguaPadrao = ? AND conhecidas.linguaEscolhida = ?;', [linguaPadrao, linguaEscolhida]);

  return data;
}

excluirConhecida(int idPalavra, String linguaEscolhida) async {
  Database db = await getDatabase();

  String linguaPadrao = (await buscarLingua()).first.values.first.toString();

  Future<int> data = db.delete('conhecidas', where: 'idPalavra = ? AND linguaPadrao = ? AND linguaEscolhida = ?', whereArgs: [idPalavra, linguaPadrao, linguaEscolhida]);

  return data;
}

Future<Map<String, Object?>> sortearPalavra(String linguaEscolhida) async {
  Database db = await getDatabase();

  String linguaPadrao = (await buscarLingua()).first.values.first.toString();

  List<Map<String, Object?>> data = await db.rawQuery('SELECT palavras.* FROM palavras LEFT JOIN conhecidas ON palavras.idPalavra = conhecidas.idPalavra AND conhecidas.linguaPadrao = ? AND conhecidas.linguaEscolhida = ? WHERE conhecidas.idPalavra IS NULL ORDER BY RANDOM() LIMIT 1;', [linguaPadrao, linguaEscolhida]);

  return data.first;
}



