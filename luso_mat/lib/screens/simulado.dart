import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_lusomat/screens/questoes.dart';
import 'package:oficial_lusomat/screens/telainicial.dart';

class TelaSimulado extends StatelessWidget {
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
        body: Center(
          child: Column(
            children: [
              Text('Filtre suas questões para o simulado',
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              DropdownMenuAnoExample(
                onAnoChanged: (String) {},
              ),
              DropdownMenuExample(
                onMateriaChanged: (String) {},
              ),
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

class DropdownMenuSimulado extends StatefulWidget {
  const DropdownMenuSimulado({super.key});

  @override
  State<DropdownMenuSimulado> createState() => _DropdownMenuSimuladoState();
}

class _DropdownMenuSimuladoState extends State<DropdownMenuSimulado> {
  String dropdownValue = 'matemática';
  final List<String> materia = <String>['matemática', 'português'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
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
  const DropdownMenuAnoSimulado({super.key});

  @override
  State<DropdownMenuAnoSimulado> createState() =>
      _DropdownMenuAnoSimuladoState();
}

class _DropdownMenuAnoSimuladoState extends State<DropdownMenuAnoSimulado> {
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
        });
      },
      items: ano.map<DropdownMenuItem<String>>((String valueAno) {
        return DropdownMenuItem<String>(
          value: valueAno,
          child: Text(valueAno),
        );
      }).toList(),
    );
  }
}

class TelaFazerSimulado extends StatefulWidget {
  @override
  _TelaFazerSimuladoState createState() => _TelaFazerSimuladoState();
}

class _TelaFazerSimuladoState extends State<TelaFazerSimulado> {
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
