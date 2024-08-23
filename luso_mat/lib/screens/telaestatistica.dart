import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import '../database/db.dart';

class TelaEstatisticas extends StatefulWidget {
  final Map<int, String> respostasSelecionadas;

  TelaEstatisticas({required this.respostasSelecionadas});

  @override
  _TelaEstatisticasState createState() => _TelaEstatisticasState();
}

class _TelaEstatisticasState extends State<TelaEstatisticas> {
  //_questoesFuture: Um Future que carrega as questões do banco de dados com base nas respostas fornecidas.
  late Future<Map<int, Map<String, dynamic>>> _questoesFuture;


  @override
  void initState() {
    super.initState();
    _questoesFuture = _fetchQuestoes();
  }
//_fetchQuestoes: Método assíncrono que busca as questões do banco de dados para cada ID presente nas respostas selecionadas. Cria um mapa (questoesMap) que associa IDs de questões aos dados das questões.


  Future<Map<int, Map<String, dynamic>>> _fetchQuestoes() async {
    final Map<int, Map<String, dynamic>> questoesMap = {};

    for (var id in widget.respostasSelecionadas.keys) {
      final questao = await getQuestao(id);
      if (questao != null) {
        questoesMap[id] = questao;
      }
    }
    //getQuestao: Método auxiliar para buscar uma questão específica do banco de dados com base no ID.

    return questoesMap;
  }

  Future<Map<String, dynamic>?> getQuestao(int id) async {
    Database db = await getDatabase();
    final List<Map<String, dynamic>> questoes = await db.query(
      'questao',
      where: 'id = ?',
      whereArgs: [id],
    );
    return questoes.isNotEmpty ? questoes.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
      ),
      body: FutureBuilder<Map<int, Map<String, dynamic>>>(
        future: _questoesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //ConnectionState.done: Verifica se o Future foi completado e os dados estão disponíveis.
            //snapshot.hasData: Verifica se os dados foram carregados corretamente.
            //widget.respostasSelecionadas: Itera sobre as respostas selecionadas para calcular a pontuação e categorizar as questões como corretas ou incorretas.

            if (snapshot.hasData) {
              final questoesMap = snapshot.data!;
              int acertos = 0;
              final total = widget.respostasSelecionadas.length;
              final List<Widget> questoesCertasWidgets = [];
              final List<Widget> questoesErradasWidgets = [];

              widget.respostasSelecionadas.forEach((id, respostaSelecionada) {
                final questao = questoesMap[id];
                final correta = questao?['resposta'] as String;
                final resultado =
                    respostaSelecionada == correta ? 'Correta' : 'Incorreta';

                if (resultado == 'Correta') {
                  acertos++;
                  questoesCertasWidgets.add(
                    ListTile(
                      title: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Questão $id',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                        ),
                      ),
                      subtitle: Center(
                        child: Text(
                          'Sua resposta: $respostaSelecionada \nResposta correta: $correta',
                        ),
                      ),
                    ),
                  );
                } else {
                  questoesErradasWidgets.add(
                    ListTile(
                      title: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Questão $id',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                        ),
                      ),
                      subtitle: Center(
                        child: Text(
                          ' Sua resposta: $respostaSelecionada\nResposta correta: $correta',
                        ),
                      ),
                    ),
                  );
                }
              });

              final porcentagemAcertos = (acertos / total) * 100;
              final porcentagemErros = 100 - porcentagemAcertos;

              return ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Text(
                    'Pontuação: $acertos/$total',
                    style: GoogleFonts.montserrat(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    child: PieChart(
                      //Gráfico de Pizza (PieChart): Mostra a porcentagem de acertos e erros usando o pacote fl_chart. PieChart: Cria um gráfico de pizza que mostra visualmente a porcentagem de acertos e erros. Utiliza o pacote fl_chart para renderizar o gráfico.
                      // https://pub.dev/packages/pie_chart
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: porcentagemAcertos,
                            color: Colors.green,
                            title: '${porcentagemAcertos.toStringAsFixed(1)}%',
                            radius: 100,
                          ),
                          PieChartSectionData(
                            value: porcentagemErros,
                            color: Colors.red,
                            title: '${porcentagemErros.toStringAsFixed(1)}%',
                            radius: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(100.0),
                          child: Text(
                            'Reveja o que você errou!',
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
                          child: Icon(
                            Icons.arrow_downward,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      'Questões Corretas',
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...questoesCertasWidgets,
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Questões Incorretas',
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...questoesErradasWidgets,
                ],
              );
            } else {
              return Center(child: Text('Nenhuma questão encontrada.'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
