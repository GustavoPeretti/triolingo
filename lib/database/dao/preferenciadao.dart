import 'package:sqflite/sqflite.dart';
import 'package:triolingo/database/db.dart';

Future<int> alterarLingua(String lingua) async {
  Database db = await getDatabase();

  if ((await db.query('preferencias')).isEmpty) {
    return await db.insert('preferencias', {'lingua': lingua}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  return await db.update('preferencias', {'lingua': lingua}, conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, Object?>>> buscarLingua() async {
  Database db = await getDatabase();

  List<Map<String, Object?>> data = await db.query('preferencias');

  return data;
}