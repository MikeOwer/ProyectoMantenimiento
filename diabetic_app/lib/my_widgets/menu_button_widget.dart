import 'package:diabetic_app/ProyectColors.dart';
import 'package:diabetic_app/pages/config_page.dart';
import 'package:diabetic_app/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:diabetic_app/pages/login_register_page.dart';
import 'package:diabetic_app/pages/quiz_lobby_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../my_classes/auth.dart';

class MenuButtonWidget extends StatefulWidget {
  const MenuButtonWidget({super.key});

  @override
  State createState() => _MenuButtonWidgetState();
}

class _MenuButtonWidgetState extends State<MenuButtonWidget> {
  final User? user = Auth().currentUser;
  void onPressed() {}
/*
  Widget menuLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () => loginButtonPressed(context),
      child: const Text(
        'Iniciar Sesión',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
  */
  Widget menuLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () => loginButtonPressed(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.login,
            color: Colors.black,
          ),
          SizedBox(width: 8), // Espacio entre el ícono y el texto
          Text(
            'Iniciar Sesión',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget menuProfileButton(BuildContext context) {
    return GestureDetector(
      onTap: () => configButtonPressed(context),
      child: const Text('Configuración'),
    );
  }

  void quizButtonPressed(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuizPage()) //Manera de entrar a el quiz rápido
        );
  }
  //Espacio para los demás métodos de acción de los botones restantes

  void loginButtonPressed(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void configButtonPressed(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ConfigPage()));
  }

  @override
  Widget build(BuildContext context) {
    final widthOfScreen = MediaQuery.of(context).size.width;
    final heightOfScreen = MediaQuery.of(context).size.height;
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.volunteer_activism,
                color: Colors.black, // Color del icono
              ),
              SizedBox(width: 8), // Espacio entre el icono y el texto
              GestureDetector(
                onTap: () => quizButtonPressed(context),
                child: const Text(
                  'Explorando tu bienestar',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        /*
        const PopupMenuItem(
          child: Row(
            children: [
              Text(
                "Opción 1",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuItem(
          child: Row(
            children: [
              Text(
                'Opción 2',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        */
        PopupMenuItem(
            child: Row(
          children: [
            menuLoginButton(context),
          ],
        )
            //child: user != null
            //  ? menuProfileButton(context)
            //  : menuLoginButton(context),
            ),
      ],
      color: ProyectColors().backgroundColor,
      constraints: BoxConstraints.expand(
          width: widthOfScreen * .80, height: heightOfScreen),
      child: const Icon(
        Icons.menu,
        size: 36,
        color: Color(0xF6F6F6F6),
      ),
    );
  }
}
