class Traducao {
  String lingua;
  String mensagemInicial;
  String comandoLingua;
  String portugues;
  String ingles;
  String latim;
  String desejoAprimorar;
  String conhecoPalavras;
  String paraRevisar;
  String palavrasConhecidas;
  String configuracoes;
  String alterarLingua;
  String linguaAtual;
  String conheco;
  String naoConheco;

  Traducao({
    required this.lingua,
    required this.mensagemInicial,
    required this.comandoLingua,
    required this.portugues,
    required this.ingles,
    required this.latim,
    required this.desejoAprimorar,
    required this.conhecoPalavras,
    required this.paraRevisar,
    required this.palavrasConhecidas,
    required this.configuracoes,
    required this.alterarLingua,
    required this.linguaAtual,
    required this.conheco,
    required this.naoConheco,
  });

  factory Traducao.fromMap(Map<String, dynamic> map) {
    return Traducao(
      lingua: map['lingua'] ?? '',
      mensagemInicial: map['mensagemInicial'] ?? '',
      comandoLingua: map['comandoLingua'] ?? '',
      portugues: map['portugues'] ?? '',
      ingles: map['ingles'] ?? '',
      latim: map['latim'] ?? '',
      desejoAprimorar: map['desejoAprimorar'] ?? '',
      conhecoPalavras: map['conhecoPalavras'] ?? '',
      paraRevisar: map['paraRevisar'] ?? '',
      palavrasConhecidas: map['palavrasConhecidas'] ?? '',
      configuracoes: map['configuracoes'] ?? '',
      alterarLingua: map['alterarLingua'] ?? '',
      linguaAtual: map['linguaAtual'] ?? '',
      conheco: map['conheco'] ?? '',
      naoConheco: map['naoConheco'] ?? '',
    );
  }
}