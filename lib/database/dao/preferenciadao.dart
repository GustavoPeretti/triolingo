import 'package:sqflite/sqflite.dart';
import 'package:triolingo/database/db.dart';

Future<int> alterarLingua(String lingua) async {
  Database db = await getDatabase();

  if ((await db.query('preferencia')).isEmpty) {
    return await db.insert('preferencia', {lingua: lingua}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  return await db.update('preferencia', {lingua: lingua}, conflictAlgorithm: ConflictAlgorithm.replace);
}
