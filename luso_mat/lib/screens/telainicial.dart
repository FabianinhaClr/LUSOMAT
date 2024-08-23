import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_lusomat/screens/questoes.dart';
import 'package:oficial_lusomat/screens/simulado.dart';
import '../main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LusoMat'),
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
                          fontSize: 30, fontWeight: FontWeight.w600)),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: Text('Simulado',
                    style: GoogleFonts.montserrat(fontSize: 16)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaSimulado()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.question_answer),
                title: Text('Questões',
                    style: GoogleFonts.montserratAlternates(fontSize: 16)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaQuestoes()),
                  );
                },
              )
            ],
          ),
        ),
        body: Escolha());
  }
}

//tela inicial parte dois
class Escolha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ColoredBox(
              color: Color.fromARGB(255, 253, 253, 253),
              child: Center(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaQuestoes()),
                    );
                  },
                  label: Text(
                    'Fazer Questões',
                    style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  icon: Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.black,
                    size: 50,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: Theme.of(context).colorScheme.primary,
              child: Center(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaSimulado()),
                      );
                    },
                    label: Text(
                      'Fazer Simulado',
                      style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.arrow_forward_sharp,
                      color: Colors.black,
                      size: 50,
                      textDirection: TextDirection.rtl,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
