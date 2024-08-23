import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:oficial_lusomat/screens/simulado.dart';
import 'package:oficial_lusomat/screens/telafazerquestoes.dart';
import 'package:oficial_lusomat/screens/telainicial.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../database/dao/questaodao.dart';
import '../main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TelaQuestoes extends StatefulWidget {
  @override
  _TelaQuestoesState createState() => _TelaQuestoesState();
}

class _TelaQuestoesState extends State<TelaQuestoes> {
  String selecionarAno = '2018';
  String selecionarMateria = 'Matemática';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Questões'),
        ),
        //Drawer: Um painel lateral que pode ser deslizado para fora da borda da tela, contendo uma lista de itens de navegação.
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              //DrawerHeader: Exibe um cabeçalho no painel lateral Drawer, geralmente usado para mostrar informações de usuário ou título.
              DrawerHeader(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 160, 37)),
                child: Center(
                    child: Text('Sumario',
                        //GoogleFonts: Uma classe que facilita o uso das fontes do Google Fonts. Utilizada aqui para aplicar fontes específicas ao texto.
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
            ],
          ),
        ),
        body: Column(children: [
          Spacer(), // Empurra o conteúdo para baixo
          Center(
            // Centraliza horizontalmente
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text('Filtre suas questões',
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 20), // Espaçamento entre os elementos
                DropdownMenuAnoExample(
                  onAnoChanged: (String newValue) {
                    setState(() {
                      selecionarAno = newValue;
                    });
                  },
                ),
                SizedBox(height: 10), // Espaçamento entre os elementos
                DropdownMenuExample(
                  onMateriaChanged: (String newValue) {
                    setState(() {
                      selecionarMateria = newValue;
                    });
                  },
                ),
                SizedBox(height: 20), // Espaçamento entre os elementos
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaResolverQuestoes(
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

//DropdownButton: Um menu suspenso para seleção de itens de uma lista. Aqui, são usados dois menus suspensos:
//DropdownMenuExample para selecionar a matéria.
//DropdownMenuAnoExample para selecionar o ano.

class DropdownMenuExample extends StatefulWidget {
  final Function(String) onMateriaChanged;

  const DropdownMenuExample({super.key, required this.onMateriaChanged});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
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

class DropdownMenuAnoExample extends StatefulWidget {
  final Function(String) onAnoChanged;

  const DropdownMenuAnoExample({super.key, required this.onAnoChanged});

  @override
  State<DropdownMenuAnoExample> createState() => _DropdownMenuAnoExampleState();
}

class _DropdownMenuAnoExampleState extends State<DropdownMenuAnoExample> {
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
