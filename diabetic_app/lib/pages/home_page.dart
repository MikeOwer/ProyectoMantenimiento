import 'package:diabetic_app/ProyectColors.dart';
import 'package:diabetic_app/my_widgets/activity_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diabetic_app/my_classes/auth.dart';
import 'package:diabetic_app/my_widgets/news_card_widget.dart';
import 'package:diabetic_app/controllers/news_controller.dart';
import 'package:diabetic_app/my_widgets/menu_button_widget.dart';
import 'package:diabetic_app/controllers/quiz_controller.dart';

class HomePage extends StatefulWidget {
  //Se visualiza las tarjetas de noticias y accesos directos
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  List<NewsCard> news = [];
  NewsController newsController = NewsController();
  QuizController quizController = QuizController.getInstance();
  bool noticeVisible = true;
  bool isVisible = true;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return Container(
      child: Center(
        child: Text(
          'Gluconexión',
          style: TextStyle(fontSize: 34.0, color: Colors.white),
        ),
      ),
    );
    /*return const Text(
      'Gluconexión',
      style: TextStyle(
        fontSize: 26, /*color: Colors.white*/
      ),
    );
    //DEBE MODIFICARSE CUANDO SE TENGA UN NOMBRE MÁS ADECUADO
    */
  }

  List<Widget> _buildNewsList() {
    //Se crea la lista de las tarjetas de las noticias.
    List<Widget> widgets = [];
    //widgets.add(const ActivityCard());
    for (int i = 0; i < news.length; i++) {
      widgets.add(news[i]);
      if (i != news.length - 1) {
        widgets.add(const SizedBox(
          height: 20,
        ));
      }
    }
    return widgets;
  }

//Cambiar el codigo, cuando haya una lista de actividades
  List<Widget> _buildActivityList() {
    List<Widget> widgets = [];
    for (int i = 0; i < 1; i++) {
      widgets.add(const ActivityCard());
    }
    return widgets;
  }

  @override
  void initState() {
    super.initState();
    loadNews();
    loadProgress();
    //updateLoginRegistry();
  }

  Future<void> loadProgress() async {
    await quizController.readProgressJSONFile();
  }

  Future<void> loadNews() async {
    await newsController.readJSONFromFile();
    setState(() {
      news = newsController.generateNewsWidgets();
    });
  }

  Future<void> updateLoginRegistry() async {
    await quizController.updateProgressJSONFile();
  }

  void _closeNoticeWidget() {
    setState(() {
      noticeVisible = false;
    });
  }

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }
  /*Widget _noticeWidget() {
    bool logedIn = (user != null);
    return Center(
      child: Card(
        color: Colors.white54,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                logedIn
                    ? '¡Bienvenido de vuelta!'
                    : 'No ha iniciado sesión o su sesión ha expirado.',
                style: const TextStyle(fontSize: 20),
              ),
              TextButton(
                onPressed: _closeNoticeWidget,
                child: const Text(
                  'Cerrar',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProyectColors().primaryColor,
        title: _title(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: MenuButtonWidget(),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Text(
            'Actividades',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          ..._buildActivityList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Noticias',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible; // Cambia el estado de visibilidad
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .transparent, // Establece el color de fondo como transparente
                  elevation:
                      0, // Opcional: Elimina la elevación para que parezca completamente plano
                ),
                child: Icon(
                  isVisible ? Icons.arrow_downward : Icons.arrow_upward,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ],
          ),
          if (isVisible) ..._buildNewsList()

          //if (noticeVisible) _noticeWidget(),
          /*SizedBox(
            height: 100,
            /*child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isVisible,
                  child: Container(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Noticias',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors
                                  .transparent, // Establece el color de fondo como transparente
                              elevation:
                                  0, // Opcional: Elimina la elevación para que parezca completamente plano
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ..._buildNewsList(),
                    ],
                  )),
                ),
              ],
            ),¨*/
          ),*/
        ],
      ),
    );
  }
}
