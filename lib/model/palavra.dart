class Palavra {
  int idPalavra;
  String grafiaPortugues;
	String grafiaIngles;
	String grafiaLatim;
	String significadoPortugues;
	String significadoIngles;
	String significadoLatim;
 
  Palavra({required this.idPalavra, required this.grafiaPortugues, required this.grafiaIngles, required this.grafiaLatim, required this.significadoPortugues, required this.significadoIngles, required this.significadoLatim});

  factory Palavra.fromMap(Map<String, dynamic> map) {
    return Palavra(
      idPalavra: map['idPalavra'] ?? 0,
      grafiaPortugues: map['grafiaPortugues'] ?? '',
      grafiaIngles: map['grafiaIngles'] ?? '',
      grafiaLatim: map['grafiaLatim'] ?? '',
      significadoPortugues: map['significadoPortugues'] ?? '',
      significadoIngles: map['significadoIngles'] ?? '',
      significadoLatim: map['significadoLatim'] ?? '',
    );
  }
}

