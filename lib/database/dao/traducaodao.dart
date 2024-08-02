import 'package:sqflite/sqflite.dart';
import 'package:triolingo/database/db.dart';

Future<List<Map<String, Object?>>> buscarTraducao(String lingua) async {
  Database db = await getDatabase();

  List<Map<String, Object?>> data = await db.query('traducoes', where: 'lingua = ?', whereArgs: [lingua]);

  return data;
}