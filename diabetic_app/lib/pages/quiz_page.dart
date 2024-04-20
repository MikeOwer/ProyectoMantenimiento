import 'dart:math';

import 'package:diabetic_app/my_classes/quiz_question.dart';
import 'package:diabetic_app/my_widgets/question_card_widget.dart';
import 'package:diabetic_app/my_widgets/quiz_option_widget.dart';
import 'package:diabetic_app/my_widgets/congrats_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:diabetic_app/controllers/quiz_controller.dart';

class QuizPage extends StatefulWidget {
  int level = 0;

  @override
  _QuizPageState createState() => _QuizPageState(level: this.level);

  QuizPage({required this.level});
}

class _QuizPageState extends State<QuizPage> {
  int level = 0;
  QuizController quizController = QuizController.getInstance();
  QuizQuestion pickedQuestion = QuizQuestion.empty();
  List<QuizOptionWidget> optionButtons = [];

  int currentStage = 0;

  bool gameStarted = false;
  bool showCard = false;
  bool correctSelected = false;
  bool incorrectSelected = false;

  _QuizPageState({required this.level});

  @override
  void initState() {
    super.initState();
    loadQuiz(level);
  }

  void loadQuiz(int level) async {
    await quizController.readJSONFromFile(level);
    //questions = quizController.selectQuizQuestions(3);
    setState(() {
      gameStarted = true;
      pickQuestion();
    });
  }

  void pickQuestion() {
    try {
      pickedQuestion = quizController.selectQuizQuestion();
      this.optionButtons = buildOptionButtons(
          pickedQuestion.correctOpt, pickedQuestion.incorrectOpts);
    } catch (e) {
      print('Exception on pickQuestion: $e');
    }
  }

  List<QuizOptionWidget> buildOptionButtons(
      String correctOpt, List<String> incorrectOpts) {
    List<QuizOptionWidget> options = [];

    //Crear botón de la opción correcta
    options.add(QuizOptionWidget(
        text: correctOpt,
        isCorrect: true,
        onTapFn: () => optionSelected(true)));

    //Crear botones de las opciones incorrectas
    for (int i = 0; i < incorrectOpts.length; i++) {
      options.add(QuizOptionWidget(
          text: incorrectOpts[i],
          isCorrect: false,
          onTapFn: () => optionSelected(false)));
    }

    return options;
  }

  void _toggleCardVisibility() {
    setState(() {
      showCard = !showCard;
    });
  }

  void optionSelected(bool isCorrect) {
    Future.delayed(Duration(milliseconds: 600), () {
      _toggleCardVisibility();
      if (isCorrect) {
        //Ejecución de la opción correcta
        setState(() {
          correctSelected = true;
        });
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            correctSelected = false;
            quizController.increaseStage();
            currentStage = quizController.getStage();
          });
          pickQuestion();
        });
      } else {
        //Ejecución de la opción incorrecta
        setState(() {
          incorrectSelected = true;
        });
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            incorrectSelected = false;
          });
          quizController.returnQuestion(pickedQuestion);
          pickQuestion();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¡Bienvenido al Quiz!'),
      ),
      body: _quizBackgroundLayout(),
    );
  }

  Widget _streetBox() {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget _grassBox(int whenToAppear) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iguana(whenToAppear),
          ],
        ),
      ),
    );
  }

  Widget _iguana(int whenToAppear) {
    Widget object;
    if (whenToAppear == quizController.stage) {
      object = SizedBox(
        height: 50,
        width: 50,
        child: Image(
          image: AssetImage("assets/images/iguana.jpg"),
        ),
      );
    } else {
      object = SizedBox();
    }
    return object;
  }

  Widget _correctGIF() {
    return const Center(
        child: Image(image: AssetImage("assets/images/correcto.gif")));
  }

  Widget _incorrectGIF() {
    return const Center(
      child: Image(image: AssetImage("assets/images/incorrecto.gif")),
    );
  }

  Widget _quizBackgroundLayout() {
    return Stack(
      //Trabaja como un espacio para acomodar widgets
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/textures/campo.jpg',
            fit: BoxFit.cover, //Para rellenar todo el fondo de la actividad
          ),
        ),
        Positioned(
          left: 125,
          right: 125,
          bottom: 0,
          top: 0,
          child: Image.asset(
            'assets/textures/textura de arbol.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned(
          left: 125,
          right: 125,
          bottom: 0,
          top: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildListaDeBotones().reversed.toList(),
            ),
          ),
        ),
        Positioned(
          right: 60,
          bottom: 0,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset('assets/images/Iguana.png')),
        ),
        if (showCard && quizController.stage < 3)
          QuestionCardWidget(pickedQuestion.question, optionButtons),
        if (currentStage >= 3) CongratsCardWidget(level: this.level),
        if (correctSelected) _correctGIF(),
        if (incorrectSelected) _incorrectGIF(),
      ],
    );
    /*return GestureDetector(
      onTap: _toggleCardVisibility,
      child: Stack(
        children: [
          Column(
            children: [
              _grassBox(3),
              _streetBox(),
              _grassBox(2),
              _streetBox(),
              _grassBox(1),
              _streetBox(),
              _grassBox(0)
            ],
          ),
          if(showCard && quizController.stage < 3)
            QuestionCardWidget(pickedQuestion.question, optionButtons),
          if(currentStage >= 3)
            CongratsCardWidget(level: this.level),
          if(correctSelected)
            _correctGIF(),
          if(incorrectSelected)
            _incorrectGIF(),
        ],
      ),
    );*/
  }

  List<Widget> _buildListaDeBotones() {
    List<Widget> buttonList = [];
    //List<QuizQuestion> questionList = quizController.getLevelQuestionsCopy();

    buttonList.add(
      _buildPrimerElemento(),
    );

    for (int i = 1; i < 4; i++) {
      buttonList.add(
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor, //Cambio de los colores a blanco
                ),
                onPressed: () {
                  _toggleCardVisibility();
                },
                child:
                    Text('Pregunta ${i + 1}', style: TextStyle(fontSize: 24)),
              ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: MediaQuery.of(context).size.height * 0.12,
              width: 15,
            ),
          ],
        ),
      );
    }

    // Añade el último elemento de manera diferente
    buttonList.add(
      _buildUltimoElemento(),
    );

    return buttonList;
  }

  Widget _buildPrimerElemento() {
    return Container(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          onPressed: () {
            _toggleCardVisibility();
          },
          child: Text(
            'Pregunta 1',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildUltimoElemento() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            onPressed: () {
              _toggleCardVisibility();
            },
            child: Text(
              'Pregunta final',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: MediaQuery.of(context).size.height * 0.12,
          width: 15,
        ),
      ],
    );
  }
}
