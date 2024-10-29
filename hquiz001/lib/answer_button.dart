import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.answerText, this.onTap, {super.key});

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        backgroundColor: const Color.fromARGB(255, 98, 0, 115),
        foregroundColor: Colors.white, //color del texto
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              40), //ctrl + espacio para abrir las sugerencias
        ),
      ),
      onPressed: onTap,
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
