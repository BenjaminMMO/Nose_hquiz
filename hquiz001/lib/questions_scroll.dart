import 'answer_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/quiz_question.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class QuestionsScroll extends StatefulWidget {
  const QuestionsScroll({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScroll> createState() {
    return _QuestionsScroll();
  }
}

class _QuestionsScroll extends State<QuestionsScroll> {
//  var currentQuestionIndex = 0;
  var currentQuestionIndex =
      1; //porque ya no usamos posiciones de una lista, sino id en una DB
  QuizQuestion currentQuestion = const QuizQuestion("", []);

  @override
  void initState() {
    super.initState();
    obtenerdelservidor(currentQuestionIndex);
  }

  Future<void> obtenerdelservidor(int id) async {
    final response = await http.get(Uri.parse(
        'http://hquiz-game.atwebpages.com/preguntas_respuestas.php?id=$id'));
    final jsonData = json.decode(response.body);

    if (jsonData['error'] == null) {
      setState(() {
        currentQuestion = QuizQuestion(
          jsonData['pregunta'],
          List<String>.from(jsonData['respuestas']),
        );
      });
    }
  }

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex += 1;
      obtenerdelservidor(currentQuestionIndex);
    });
  }

  @override
  Widget build(context) {
    //final currentQuestion = questions[currentQuestionIndex];

    return Container(
      margin: const EdgeInsets.all(80),
      child: SizedBox(
        width: double.infinity, //hace que use todo el ancho posible
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, //hay varios alineamientos posibles
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // llenaran todo el ancho del contenedor
          children: [
            Text(
              textAlign: TextAlign.center,
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1),
            ...currentQuestion.getSuffledAnswers().map((answer) {
              //los ... sirve para reemplaza todo por solo el AnswerButton resultado, separado por coma
              return AnswerButton(answer, () {
                answerQuestion(answer);
              });
            }) //convierte los strings a widgets
            /*
            AnswerButton(
              currentQuestion.answers[0],
              () {},
            ),
            AnswerButton(
              currentQuestion.answers[1],
              () {},
            ),
            AnswerButton(
              currentQuestion.answers[2],
              () {},
            ),
            AnswerButton(
              currentQuestion.answers[3],
              () {},
            ),
            */
          ],
        ),
      ),
    );
    /*
    const Center(
      child: Text('QuestionsScreen'),
    );
    */
  }
}
