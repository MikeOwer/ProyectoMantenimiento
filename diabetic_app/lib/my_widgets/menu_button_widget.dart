import 'package:diabetic_app/controllers/login_controller.dart';
import 'package:diabetic_app/pages/config_page.dart';
import 'package:diabetic_app/pages/login_register_page.dart';
import 'package:diabetic_app/pages/quiz_page.dart';
import 'package:flutter/material.dart';

class MenuButtonWidget extends StatefulWidget {
  const MenuButtonWidget({super.key});

  @override
  State createState() => _MenuButtonWidgetState();
}

class _MenuButtonWidgetState extends State<MenuButtonWidget> {
  //final User? user = Auth().currentUser;
  LoginController loginController = LoginController.getInstance();
  bool logedIn = false; //(user != null);

  void onPressed() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadUserData();
  }

  Future<void> loadUserData() async {
    await loginController.readUserDataJSONFile();
    setState(() {
      logedIn = loginController.getEmail() != "" &&
          loginController.getPassword() != "";
      print("Menu -> loginController.getEmail(): ${loginController.getEmail()}, loginController.getPassword(): ${loginController.getPassword()}");
      print("Menu -> Valor de logedIn: $logedIn");
    });
  }

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
            context, MaterialPageRoute(builder: (context) => const LoginPage()))
        .then((value) => setState(() {
              logedIn = loginController.getEmail() != "" &&
                  loginController.getPassword() != "";
            }));
  }

  void configButtonPressed(BuildContext context) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ConfigPage()))
        .then((value) => setState(() {
              logedIn = loginController.getEmail() != "" &&
                  loginController.getPassword() != "";
            }));
  }

  @override
  Widget build(BuildContext context) {
    /*if (logedIn = loginController.getEmail() != "" &&
        loginController.getPassword() != "") {
    logedIn = true;
    }*/
    setState(() {
      logedIn = loginController.getEmail() != "" &&
          loginController.getPassword() != "";
    });
    print("menu -> loginController.getName(): ${loginController.getName()},loginController.getEmail(): ${loginController.getEmail()}, loginController.getPassword(): ${loginController.getPassword()}");
    print("menu -> valorcito de logedIn: $logedIn");

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
          //child: menuLoginButton(context),
          child:
              logedIn ? menuProfileButton(context) : menuLoginButton(context),
        ),
      ],
      child: const Icon(
        Icons.menu,
        size: 36,
      ),
    );
  }
}
