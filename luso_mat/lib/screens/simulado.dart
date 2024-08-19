import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_lusomat/screens/questoes.dart';
import 'package:oficial_lusomat/screens/telaestatistica.dart';
import 'package:oficial_lusomat/screens/telainicial.dart';
import 'package:sqflite/sqflite.dart';
import '../database/dao/questaodao.dart';
import '../database/db.dart';

class TelaSimulado extends StatefulWidget {
  @override
  State<TelaSimulado> createState() => _TelaSimuladoState();
}

class _TelaSimuladoState extends State<TelaSimulado> {
  String selectedAno = '2018';
  String selectedMateria = 'Matemática';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulado'),
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
      body: Center(
        child: Column(
          children: [
            Text('Filtre suas questões para o simulado',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.w600)),
            DropdownMenuAnoSimulado(
              onAnoChanged: (String newValue) {
                setState(() {
                  selectedAno = newValue;
                });
              },
            ),
            DropdownMenuSimulado(
              onMateriaChanged: (String newValue) {
                setState(() {
                  selectedMateria = newValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaFazerSimulado(
                      selectedMateria: selectedMateria,
                      selectedAno: selectedAno,
                    ),
                  ),
                );
              },
              child: const Text('Vamos lá'),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownMenuSimulado extends StatefulWidget {
  final Function(String) onMateriaChanged;

  const DropdownMenuSimulado({super.key, required this.onMateriaChanged});

  @override
  State<DropdownMenuSimulado> createState() => _DropdownMenuSimuladoState();
}

class _DropdownMenuSimuladoState extends State<DropdownMenuSimulado> {
  String valormateria = 'Matemática';
  final List<String> materia = <String>['Matemática', 'Português'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: valormateria,
      onChanged: (String? newValue) {
        setState(() {
          valormateria = newValue!;
          widget.onMateriaChanged(valormateria);
        });
      },
      items: materia.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropdownMenuAnoSimulado extends StatefulWidget {
  final Function(String) onAnoChanged;

  const DropdownMenuAnoSimulado({super.key, required this.onAnoChanged});

  @override
  State<DropdownMenuAnoSimulado> createState() =>_DropdownMenuAnoSimuladoState();
}

class _DropdownMenuAnoSimuladoState extends State<DropdownMenuAnoSimulado> {
  String dropdownValue = '2018';
  final List<String> ano = <String>[
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          widget.onAnoChanged(dropdownValue);
        });
      },
      items: ano.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class TelaFazerSimulado extends StatefulWidget {
  final String? selectedMateria;
  final String? selectedAno;

  TelaFazerSimulado({this.selectedMateria, this.selectedAno});

  @override
  _TelaFazerSimuladoState createState() => _TelaFazerSimuladoState();
}

class _TelaFazerSimuladoState extends State<TelaFazerSimulado> {
  final Map<int, String> respostasSelecionadas = {};

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
        selectedMateria: widget.selectedMateria,
        selectedAno: widget.selectedAno,
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
  final String? selectedMateria;
  final String? selectedAno;
  final Map<int, String> respostasSelecionadas;
  final Function(int id, String respostaSelecionada) onRespostaSelecionada;

  GeraisSimulado({
    this.selectedMateria,
    this.selectedAno,
    required this.respostasSelecionadas,
    required this.onRespostaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: findall(materia: selectedMateria, ano: selectedAno),
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
