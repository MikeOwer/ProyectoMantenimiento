import 'package:flutter/material.dart';

class QuestionButtonForTest extends StatelessWidget {
  final int currentQuestion;
  final int position;

  const QuestionButtonForTest({
    Key? key,
    required this.currentQuestion,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              backgroundColor: position <= currentQuestion
                  ? Color(0xFF002556)
                  : Colors.white,
              disabledBackgroundColor:
                  position > currentQuestion ? Colors.white : Color(0xFF002556),
              //Se desabilita el widget si el botón es mayor a la pregunta actual
            ),
            onPressed:
                position != currentQuestion ? null : () => print(position),
            child: Text(
              'Pregunta ${position}',
            )),
      ),
    );
  }
}
