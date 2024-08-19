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
  late Future<Map<int, Map<String, dynamic>>> _questoesFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _questoesFuture = _fetchQuestoes();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Map<int, Map<String, dynamic>>> _fetchQuestoes() async {
    final Map<int, Map<String, dynamic>> questoesMap = {};

    for (var id in widget.respostasSelecionadas.keys) {
      final questao = await getQuestao(id);
      if (questao != null) {
        questoesMap[id] = questao;
      }
    }

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
                      title: Text(
                        'Questão $id',
                        style: TextStyle(color: Colors.green),
                      ),
                      subtitle: Text(
                        'Sua resposta: $respostaSelecionada\nResposta correta: $correta',
                      ),
                    ),
                  );
                } else {
                  questoesErradasWidgets.add(
                    ListTile(
                      title: Text(
                        'Questão $id',
                        style: TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(
                        'Sua resposta: $respostaSelecionada\nResposta correta: $correta',
                      ),
                    ),
                  );
                }
              });

              final porcentagemAcertos = (acertos / total) * 100;
              final porcentagemErros = 100 - porcentagemAcertos;

              return ListView(
                controller: _scrollController,
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
                  Text(
                    'Questões Corretas',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...questoesCertasWidgets,
                  SizedBox(height: 16),
                  Text(
                    'Questões Incorretas',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
