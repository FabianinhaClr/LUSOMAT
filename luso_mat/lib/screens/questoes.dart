import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:oficial_lusomat/screens/simulado.dart';
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
  String selectedAno = '2015';
  String selectedMateria = 'Matemática';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questões'),
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
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Filtre suas questões',
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            DropdownMenuAnoExample(
              onAnoChanged: (String newValue) {
                setState(() {
                  selectedAno = newValue;
                });
              },
            ),
            DropdownMenuExample(
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
                    builder: (context) => TelaResolverQuestoes(
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
  String dropdownValue = '2015';
  final List<String> ano = <String>[
    '2015',
    '2016',
    '2017',
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

class Gerais extends StatelessWidget {
  final String? selectedMateria;
  final String? selectedAno;

  Gerais({this.selectedMateria, this.selectedAno});

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
            List<Map> dados = snapshot.data as List<Map>;

            return ListView.builder(
              itemCount: dados.length,
              itemBuilder: (context, index) {
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
                          "${dados[index]['materia']}, ${dados[index]['ano']}:",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text('${dados[index]['questao']}',
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.montserrat()),
                      ),
                      Row(
                        children: [
                          TextButton(onPressed: () {}, child: Text('A')),
                          Container(
                              child: Text(
                            '${dados[index]['opcaoA']}',
                            overflow: TextOverflow.visible,
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(onPressed: () {}, child: Text('B')),
                          Container(
                              child: Text(
                            '${dados[index]['opcaoB']}',
                            overflow: TextOverflow.visible,
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(onPressed: () {}, child: Text('C')),
                          Container(
                              child: Text(
                            '${dados[index]['opcaoC']}',
                            overflow: TextOverflow.visible,
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(onPressed: () {}, child: Text('D')),
                          Container(
                              child: Text(
                            '${dados[index]['opcaoD']}',
                            overflow: TextOverflow.visible,
                          ))
                        ],
                      )
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
