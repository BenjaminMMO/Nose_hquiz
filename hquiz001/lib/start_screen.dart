import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownExample extends StatefulWidget {
  const DropdownExample({
    super.key,
    required this.pepa,
    /*required this.higth*/
  });
  final List<String> pepa;
  //final int higth;

  @override
  State<DropdownExample> createState() {
    return _DropdownExampleState();
  }
}

class _DropdownExampleState extends State<DropdownExample> {
  String? selectedValue; //significa que son null
  List<String> p = [];
  //int? altura;

  //debo crear un método porque se la inicialización de esta clase se hace sin garantizarse que
  //sea luego de la anterior
  void inicializalista() {
    p = widget.pepa;
    //altura = widget.higth;
  }
/*
  final List<String> options = [
    'Flutter',
    'C++',
    'JAVA',
    'PYTHON',
    'Personalizado',
  ];
  */

  @override
  Widget build(BuildContext context) {
    inicializalista();
    return DropdownButton<String>(
      value: selectedValue,
      hint: const Text('Selecciona una opción'),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      items: p.map<DropdownMenuItem<String>>((String value) {
        //p puede ser vacio, pero no null
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen(this.switchScreen, {super.key});

  final void Function() switchScreen;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Opacity(
          //opacity: 0.75,
          //child:
          Image.asset(
            'lib/assets/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          //),
          const SizedBox(height: 20),
          Text(
            "Bienvenido a HQuiz",
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 20,
            ),
            /*
            TextStyle(
              color: Colors.white,
              fontSize: 20,
            )
            */
          ),
          const SizedBox(
            height: 30,
          ),

          const DropdownExample(
            pepa: [
              'C++',
              'Flutter',
              'Python',
              'JAVA',
              'Personalizado',
            ],
            //higth: 5 * 40,
          ),

          const SizedBox(
            height: 30,
          ),

          const DropdownExample(
            pepa: [
              'QuickGame',
              'HardMode',
              'TimeTrial',
              'QuickChallenge',
              'CustomChallenge',
            ],
            //higth: 5 * 40,
          ),

          const SizedBox(
            height: 30,
          ),

          OutlinedButton.icon(
            icon: const Icon(
              Icons.arrow_right_alt,
            ),
            onPressed: switchScreen,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            //child: const Text("Start Quizz"),
            label: const Text("Start Quizz"),
          )
        ],
      ),
    );
  }
}
