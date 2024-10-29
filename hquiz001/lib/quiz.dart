import 'questions_scroll.dart';
import 'package:flutter/material.dart';
import 'start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  //esas 2 sentencias pasan al mismo tiempo casi, tonces no esta garantizado
  //Widget activeScreen = const StartScreen(switchScreen); //pasa un puntero

  final List<String> selectedAnswers = [];
  Widget? activeScreen; //significa que es null por ahora

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    /*
    if (selectedAnswers.length >= questions.length) {
      setState(() {
        activeScreen = StartScreen(switchScreen);
        //se lleno la lista de respuestas
      });
    }
    */ //ya no estamos usando una lista para los valores, sino el id corresponde a una DB
    if (selectedAnswers.length == 6) {
      setState(() {
        //aqui en vez de hacer eso, deberiamos ver tiempos y score
        activeScreen = StartScreen(switchScreen);
      });
    }
  }

  @override
  void initState() {
    // ESTA inicializacion se ejecuta antes que switchSrceen
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScroll(onSelectAnswer: chooseAnswer);
    });
  }

  @override
  Widget build(context) {
    /* metodo alternativo
    Widget screenWidget = StartScreen(switchScreen);
    if (activeScreen == 'questions-screen') {
      screenWidget = const QuestionsScroll();
    }
    */

    return MaterialApp(
      home: Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: activeScreen)
          /*Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("Learn Flutter the fun way!",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        SizedBox(
          height: 30,
        ),
        OutlinedButton(
            onPressed: null,
            child: Text("Start Quiz",
                style: TextStyle(color: Colors.white, fontSize: 16)))
      ]))*/
          //,
          //backgroundColor: Color.fromRGBO(240, 0, 255, 0.6),
          ),
    );
  }
}
