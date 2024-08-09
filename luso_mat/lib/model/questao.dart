class Questao {
  int? id;
  String questao;
  String materia;
  int ano;
  String opcaoA;
  String opcaoB;
  String opcaoC;
  String opcaoD;
  String resposta;

  Questao(
      {this.id,
      required this.questao,
      required this.materia,
      required this.ano,
      required this.opcaoA,
      required this.opcaoB,
      required this.opcaoC,
      required this.opcaoD,
      required this.resposta});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'questao': questao,
      'materia': materia,
      'ano': ano,
      'opcaoA': opcaoA,
      'opcaoB': opcaoB,
      'opcaoC': opcaoC,
      'opcaoD': opcaoD,
      'resposta': resposta
    };
  }

  String toSring() {
    return 'Questao: {ID: $id, Questao: $questao, materia: $materia, ano: $ano, opcapA: $opcaoA, opcapB: $opcaoB, opcapC: $opcaoC, opcapD: $opcaoD,  resposta: $resposta}';
  }
}
