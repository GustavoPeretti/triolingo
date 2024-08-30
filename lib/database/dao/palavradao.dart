import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:triolingo/database/dao/preferenciadao.dart';
import 'package:triolingo/database/db.dart';

Future<List<Map<String, Object?>>> buscarPares(String linguaPadrao, String linguaDesejada) async {
  Database db = await getDatabase();

  String grafia = 'grafia${linguaDesejada[0].toUpperCase()}${linguaDesejada.substring(1).toLowerCase()}';
  String significado = 'significado${linguaPadrao[0].toUpperCase()}${linguaPadrao.substring(1).toLowerCase()}';

  List<Map<String, Object?>> data = await db.query('palavras', columns: ['idPalavra', grafia, significado]);

  return data;
}


Future<Map<String, Object?>> sortearPalavra(String linguaEscolhida) async {
  Database db = await getDatabase();

  String linguaPadrao = (await buscarLingua()).first.values.first.toString();

  List<Map<String, Object?>> data = await db.rawQuery('SELECT * FROM palavras WHERE idPalavra NOT IN (SELECT idPalavra FROM conhecidas WHERE linguaPadrao LIKE ? AND linguaEscolhida LIKE ? UNION SELECT idPalavra FROM revisao WHERE linguaPadrao LIKE ? AND linguaEscolhida LIKE ?) ORDER BY RANDOM() LIMIT 1;', [linguaPadrao, linguaEscolhida, linguaPadrao, linguaEscolhida]);

  debugPrint(data.toString());

  return data.first;
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

Future<int> excluirConhecida(int idPalavra, String linguaEscolhida) async {
  Database db = await getDatabase();

  String linguaPadrao = (await buscarLingua()).first.values.first.toString();

  Future<int> data = db.delete('conhecidas', where: 'idPalavra = ? AND linguaPadrao = ? AND linguaEscolhida = ?', whereArgs: [idPalavra, linguaPadrao, linguaEscolhida]);

  return data;
}

Future<int> cadastrarDesconhecida(int idPalavra, String linguaPadrao, String linguaDesejada) async {
  Database db = await getDatabase();

  return await db.insert('revisao', {'idPalavra': idPalavra, 'linguaPadrao': linguaPadrao, 'linguaEscolhida': linguaDesejada}, conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, Object?>>> buscarDesconhecidas(String linguaEscolhida) async {
  Database db = await getDatabase();

  String linguaPadrao = (await buscarLingua()).first.values.first.toString();

  Future<List<Map<String, Object?>>> data = db.rawQuery('SELECT palavras.* FROM revisao INNER JOIN palavras ON revisao.idPalavra = palavras.idPalavra WHERE revisao.linguaPadrao = ? AND revisao.linguaEscolhida = ?;', [linguaPadrao, linguaEscolhida]);

  return data;
}

Future<int> checarDesconhecida(int idPalavra, String linguaEscolhida) async {
  Database db = await getDatabase();

  String linguaPadrao = (await buscarLingua()).first.values.first.toString();

  Future<int> dataExclusao = db.delete('revisao', where: 'idPalavra = ? AND linguaPadrao = ? AND linguaEscolhida = ?', whereArgs: [idPalavra, linguaPadrao, linguaEscolhida]);

  Future<int> dataCadastro = cadastrarConhecida(idPalavra, linguaPadrao, linguaEscolhida);

  bool data = ((await dataExclusao) == 1) && ((await dataCadastro) == 1);

  return data ? 1 : 0;
}

Future<int> contarConhecidas(String linguaEscolhida) async {
  return (await buscarConhecidas(linguaEscolhida)).length;
}

Future<int> contarDesconhecidas(String linguaEscolhida) async {
  return (await buscarDesconhecidas(linguaEscolhida)).length;
}