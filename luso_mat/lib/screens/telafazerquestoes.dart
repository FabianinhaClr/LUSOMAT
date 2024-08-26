import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_lusomat/database/dao/questaodao.dart';
import 'package:oficial_lusomat/screens/questoes.dart';
import 'package:oficial_lusomat/screens/simulado.dart';
import 'package:oficial_lusomat/screens/telainicial.dart';

class TelaResolverQuestoes extends StatefulWidget {
  final String? selecionarMateria;
  final String? selecionarAno;

  TelaResolverQuestoes({this.selecionarMateria, this.selecionarAno});

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
        selecionarMateria: widget.selecionarMateria,
        selecionarAno: widget.selecionarAno,
      ),
    );
  }
}

class Gerais extends StatefulWidget {
  final String? selecionarMateria;
  final String? selecionarAno;

  Gerais({this.selecionarMateria, this.selecionarAno});

  @override
  State<Gerais> createState() => _GeraisState();
}

class _GeraisState extends State<Gerais> {
  Map<int, String> _respostasSelecionadas = {};
  Map<int, String> _mensagensFeedback = {};
  final _key = PageStorageKey('pageStorageKey');
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future:
          findall(materia: widget.selecionarMateria, ano: widget.selecionarAno),
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
              key: _key,
              controller: _controller,
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

                      //lista com as opcoes clicaveis
                      _opcoes(item, id, 'A'),
                      _opcoes(item, id, 'B'),
                      _opcoes(item, id, 'C'),
                      _opcoes(item, id, 'D'),
                      if (_respostasSelecionadas.containsKey(id))
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(100.0),
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

  Widget _opcoes(Map item, int id, String letra) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            _verificarResposta(letra, '${item['resposta']}', id);
          },
          child: Text(letra),
          style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              textStyle: TextStyle(color: Colors.black)),
        ),
        //esse flexivel aqui é por causa que a tela da problema se nn colocar
        Flexible(
          child: Text(
            '${item['opcao$letra']}',
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
