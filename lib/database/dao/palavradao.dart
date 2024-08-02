import 'package:sqflite/sqflite.dart';
import 'package:triolingo/database/db.dart';

Future<List<Map<String, Object?>>> buscarPares(String linguaPadrao, String linguaDesejada) async {
  Database db = await getDatabase();

  String grafia = 'grafia${linguaDesejada[0].toUpperCase()}${linguaDesejada.substring(1).toLowerCase()}';
  String significado = 'significado${linguaPadrao[0].toUpperCase()}${linguaPadrao.substring(1).toLowerCase()}';

  List<Map<String, Object?>> data = await db.query('traducoes', columns: ['idPalavra', grafia, significado]);

  return data;
}


