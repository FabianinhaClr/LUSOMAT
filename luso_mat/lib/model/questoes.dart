class Questao {
  int? id;
  String questao;
  String materia;
  int ano;
  String resposta;

  Questao(
      {this.id,
      required this.questao,
      required this.materia,
      required this.ano,
      required this.resposta});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'questao': questao,
      'materia': materia,
      'ano': ano,
      'resposta': resposta
    };
  }

  String toSring() {
    return 'Questao: {ID: $id, Questao: $questao, materia: $materia, ano: $ano, resposta: $resposta}';
  }
}
