import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oficial_lusomat/screens/simulado.dart';
import 'package:oficial_lusomat/screens/telainicial.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../main.dart';

class TelaQuestoes extends StatefulWidget {
  @override
  _TelaQuestoesState createState() => _TelaQuestoesState();
}

class _TelaQuestoesState extends State<TelaQuestoes> {
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
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 160, 37)),
                child: Text('Sumario', style: GoogleFonts.montserrat()),
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
              DropdownMenuAnoExample(),
              DropdownMenuExample(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaResolverQuestoes()),
                  );
                },
                child: const Text('Vamos lá'),
              ),
            ],
          ),
        ));
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = 'Matemática';
  final List<String> list = <String>['Matemática', 'Português'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropdownMenuAnoExample extends StatefulWidget {
  const DropdownMenuAnoExample({super.key});

  @override
  State<DropdownMenuAnoExample> createState() => _DropdownMenuAnoExampleState();
}

class _DropdownMenuAnoExampleState extends State<DropdownMenuAnoExample> {
  String dropdownValue = '2015';
  final List<String> list = <String>[
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
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class TelaResolverQuestoes extends StatefulWidget {
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
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 160, 37)),
                child: Text('Sumario', style: GoogleFonts.montserrat()),
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
        body: null);
  }
}
