
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_lusomat/screens/questoes.dart';
import 'package:oficial_lusomat/screens/simulado.dart';
import 'package:oficial_lusomat/screens/telaestatistica.dart';
import 'package:oficial_lusomat/screens/telainicial.dart';

import '../database/dao/questaodao.dart';

class TelaFazerSimulado extends StatefulWidget {
  final String? selecionarMateria;
  final String? selecionarAno;

  TelaFazerSimulado({this.selecionarMateria, this.selecionarAno});

  @override
  _TelaFazerSimuladoState createState() => _TelaFazerSimuladoState();
}

class _TelaFazerSimuladoState extends State<TelaFazerSimulado> {
  final Map<int, String> respostasSelecionadas = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fazer Simulado'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 243, 160, 37)),
              child: Center(
                  child: Text('Sumario',
                      style: GoogleFonts.montserrat(
                          fontSize: 30, fontWeight: FontWeight.w600))),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Tela Inicial'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Simulado'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaSimulado()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Questões'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaQuestoes()),
                );
              },
            ),
          ],
        ),
      ),
      body: GeraisSimulado(
        selecionarMateria: widget.selecionarMateria,
        selecionarAno: widget.selecionarAno,
        onRespostaSelecionada: (id, respostaSelecionada) {
          setState(() {
            respostasSelecionadas[id] = respostaSelecionada;
          });
        },
        respostasSelecionadas: respostasSelecionadas,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaEstatisticas(
                respostasSelecionadas: respostasSelecionadas,
              ),
            ),
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}


class GeraisSimulado extends StatelessWidget {
  final String? selecionarMateria;
  final String? selecionarAno;
  final Map<int, String> respostasSelecionadas;
  final Function(int id, String respostaSelecionada) onRespostaSelecionada;

  GeraisSimulado({
    this.selecionarMateria,
    this.selecionarAno,
    required this.respostasSelecionadas,
    required this.onRespostaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: findall(materia: selecionarMateria, ano: selecionarAno),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
                child: Text("Houve um erro de Conexão com o Banco de Dados"));

          case ConnectionState.active:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }
            List<Map> dados = snapshot.data as List<Map>;

            return ListView.builder(
              itemCount: dados.length,
              itemBuilder: (context, index) {
                final questao = dados[index];
                final id = questao['id'] as int;

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 0,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      Container(
                        child: Text(
                          "${questao['materia']}, ${questao['ano']}:",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text('${questao['questao']}',
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.montserrat()),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _verificarRespostaSimulado(
                                  id, 'A', questao['resposta'], context);
                            },
                            child: Text('A'),
                          ),
                          Flexible(
                            child: Text(
                              '${questao['opcaoA']}',
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _verificarRespostaSimulado(
                                  id, 'B', questao['resposta'], context);
                            },
                            child: Text('B'),
                          ),
                          Flexible(
                            child: Text(
                              '${questao['opcaoB']}',
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _verificarRespostaSimulado(
                                  id, 'C', questao['resposta'], context);
                            },
                            child: Text('C'),
                          ),
                          Flexible(
                            child: Text(
                              '${questao['opcaoC']}',
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _verificarRespostaSimulado(
                                  id, 'D', questao['resposta'], context);
                            },
                            child: Text('D'),
                          ),
                          Flexible(
                            child: Text(
                              '${questao['opcaoD']}',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }

  void _verificarRespostaSimulado(int id, String respostaSelecionada,
      String resposta, BuildContext context) {
    onRespostaSelecionada(id, respostaSelecionada);

    if (respostaSelecionada == resposta) {
      Text('Resposta correta!');
    } else {
      Text('Resposta incorreta!');
    }
  }
}
