import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_lusomat/database/dao/questaodao.dart';
import 'package:oficial_lusomat/screens/questoes.dart';
import 'package:oficial_lusomat/screens/simulado.dart';
import 'package:oficial_lusomat/screens/telainicial.dart';

class TelaResolverQuestoes extends StatefulWidget {
  final String? selectedMateria;
  final String? selectedAno;

  TelaResolverQuestoes({this.selectedMateria, this.selectedAno});

  @override
  _TelaResolverQuestoesState createState() => _TelaResolverQuestoesState();
}

class _TelaResolverQuestoesState extends State<TelaResolverQuestoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resolver Questões'),
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
      body: Gerais(
        selectedMateria: widget.selectedMateria,
        selectedAno: widget.selectedAno,
      ),
    );
  }
}

class Gerais extends StatefulWidget {
  final String? selectedMateria;
  final String? selectedAno;

  Gerais({this.selectedMateria, this.selectedAno});

  @override
  State<Gerais> createState() => _GeraisState();
}

class _GeraisState extends State<Gerais> {
  Map<int, String> _respostasSelecionadas = {};
  Map<int, String> _mensagensFeedback = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: findall(materia: widget.selectedMateria, ano: widget.selectedAno),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
                child: Text("Houve um erro de Conexão com o Banco de Dados"));

          case ConnectionState.active:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            List<Map> dados = snapshot.data as List<Map>;

            return ListView.builder(
              // controller: rolagem,
              itemCount: dados.length,
              itemBuilder: (context, index) {
                var item = dados[index];
                var id = index;

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
                          color: Colors.white),
                      Container(
                        child: Text(
                          "${item['materia']}, ${item['ano']}:",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text('${item['questao']}',
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.montserrat()),
                      ),
                      _buildOptionRow(item, id, 'A'),
                      _buildOptionRow(item, id, 'B'),
                      _buildOptionRow(item, id, 'C'),
                      _buildOptionRow(item, id, 'D'),
                      if (_respostasSelecionadas.containsKey(id))
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            color: _mensagensFeedback[id] == 'Resposta correta!'
                                ? Color.fromARGB(255, 171, 205, 255)
                                : Color.fromARGB(255, 243, 160, 37),
                            child: Text(
                              _mensagensFeedback[id]!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18.0),
                            ),
                          ),
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

  Widget _buildOptionRow(Map item, int id, String option) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            _verificarResposta(option, '${item['resposta']}', id);
          },
          child: Text(option),
          style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              textStyle: TextStyle(color: Colors.black)),
        ),
        Flexible(
          child: Text(
            '${item['opcao$option']}',
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  void _verificarResposta(String respostaSelecionada, String resposta, int id) {
    setState(() {
      if (respostaSelecionada == resposta) {
        _respostasSelecionadas[id] = respostaSelecionada;
        _mensagensFeedback[id] = 'Resposta correta!';
      } else {
        _respostasSelecionadas[id] = respostaSelecionada;
        _mensagensFeedback[id] = 'Resposta incorreta!';
      }
    });
  }
}
