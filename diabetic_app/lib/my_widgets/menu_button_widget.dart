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

  Widget menuLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () => loginButtonPressed(context),
      child: const Text('Iniciar Sesión'),
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
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: GestureDetector(
            onTap: () => quizButtonPressed(context),
            child: const Text('Explorando tu bienestar'),
          ),
        ),
        const PopupMenuItem(
          child: Row(
            children: [
              Text('Opción 1'),
            ],
          ),
        ),
        const PopupMenuItem(
          child: Row(
            children: [
              Text('Opción 2'),
            ],
          ),
        ),
        PopupMenuItem(
          child: menuLoginButton(context),
          //child: user != null
          //  ? menuProfileButton(context)
          //  : menuLoginButton(context),
        ),
      ],
      child: const Icon(
        Icons.menu,
        size: 36,
      ),
    );
  }
}
