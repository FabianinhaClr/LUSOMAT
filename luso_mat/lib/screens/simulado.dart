import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_lusomat/screens/questoes.dart';
import 'package:oficial_lusomat/screens/telaestatistica.dart';
import 'package:oficial_lusomat/screens/telafazersimulado.dart';
import 'package:oficial_lusomat/screens/telainicial.dart';
import 'package:sqflite/sqflite.dart';
import '../database/dao/questaodao.dart';
import '../database/db.dart';

class TelaSimulado extends StatefulWidget {
  @override
  State<TelaSimulado> createState() => _TelaSimuladoState();
}

class _TelaSimuladoState extends State<TelaSimulado> {
  String selecionarAno = '2018';
  String selecionarMateria = 'Matemática';

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
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 160, 37)),
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
        body: Column(children: [
          Spacer(), // Vai empurrar o conteúdo para baixo LEMBRAA
          Center(
            child: Column(
              children: [
                Text('Filtre suas questões para o simulado',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                SizedBox(height: 20),
                DropdownMenuAnoSimulado(
                  onAnoChanged: (String newValue) {
                    setState(() {
                      selecionarAno = newValue;
                    });
                  },
                ),
                SizedBox(height: 10),
                DropdownMenuSimulado(
                  onMateriaChanged: (String newValue) {
                    setState(() {
                      selecionarMateria = newValue;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaFazerSimulado(
                          selecionarMateria: selecionarMateria,
                          selecionarAno: selecionarAno,
                        ),
                      ),
                    );
                  },
                  child: const Text('Vamos lá'),
                ),
              ],
            ),
          ),
          Spacer()
        ]));
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
  State<DropdownMenuAnoSimulado> createState() =>
      _DropdownMenuAnoSimuladoState();
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
