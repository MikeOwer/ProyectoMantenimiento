import 'package:diabetic_app/pages/quiz_page.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard(
      {super.key}); //Tarjeta creada para acceso directo con la actividad.

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    QuizPage()) //Manera de entrar a el quiz rápido
            );
      },
      child: Column(
        children: [
          Container(
            width:
                MediaQuery.of(context).size.width * 5, // Ancho deseado del card
            height: 200,
            //padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              color: const Color(0xFF002556), //Color de fondo de las tarjetas
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 150, // Ancho deseado del card
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/Iguana con traje de doctor.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          height: 120.0, // Establece la altura deseada
                          child: const ListTile(
                            title: Text(
                              "Explorando tu bienestar",
                              maxLines:
                                  3, // Define el número máximo de líneas que se mostrarán
                              overflow: TextOverflow
                                  .ellipsis, // Agrega puntos suspensivos
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          //el lenguaje pide ponerle const
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "¡Comencemos!",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'Montserrat-SemiBold.ttf',
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Noticias',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(width: 15.0), // Espaciado entre el texto y el icono
                Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                  size: 35,
                ),
                SizedBox(height: 8.0), // Espaciado entre el icono y el texto
              ],
            ),
          )
        ],
      ),
    );
  }
}
