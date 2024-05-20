import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';

class LoginController {
  //Clase no trabajada aún, se tiene que modificar para hacer match con la API.
  String id = "";
  String name = "";
  String email = "";
  String password = "";
  int numNivel = 0;
  int numPregunta = 0;

  static LoginController? _instance;

  LoginController._();

  static LoginController getInstance() {
    _instance ??= LoginController._();
    return _instance!;
  }


  String getId(){
    return id;
}

  String getName() {
    return name;
  }

  String getEmail() {
    return email;
  }

  String getPassword() {
    return password;
  }

  // Obtener el path del archivo
  Future<String> _getUserDataFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    print('${directory.path}/userData.json');
    return '${directory.path}/userData.json';
  }

  Future<bool> userDataFileExist() async {
    final directory = await _getUserDataFilePath();
    File file = File(directory);
    return await file.exists() ? true : false;
  }

  // Crear el archivo userToken.json
  Future<void> createUserDataJSONFile(Map<String, dynamic> jsonData) async {
    String path = await _getUserDataFilePath();
    String jsonString = json.encode(jsonData);
    File file = File(path);
    file.writeAsStringSync(jsonString);
    id = jsonData["id"] as String;
    name = jsonData["name"];
    email = jsonData["email"];
    password = jsonData["password"];
    numNivel = jsonData["numNivel"];
    numPregunta = jsonData["numPregunta"];
    print("Json guardado en dirección: $path");
  }

  //Leer el contenido de userToken.json
  Future<void> readUserDataJSONFile() async {
    try {
      String path = await _getUserDataFilePath(); //Se obtiene la ruta del json
      File file = File(path);
      if (await file.exists()) {
        String response = await file.readAsString();
        final data = await json
            .decode(response); //Se obtiene el Json con el que se trabajará

        id = data['id'];
        name = data['name'];
        email = data['email'];
        password = data['password'];
        print("name: $name, email: $email, password: $password");
      }
    } catch (e) {
      print('Exception catched: $e');
    }
  }

  Future<bool> userExistInJSONFile(String email, String password) async {
    bool userExist = false;
    try {
      String path = await _getUserDataFilePath();
      print(path); //Se obtiene la ruta del json
      File file = File(path);
      if (await file.exists()) {
        String response = await file.readAsString();
        final data = await json
            .decode(response); //Se obtiene el Json con el que se trabajará
        print("email: ${data['email']}, password: ${data['password']}");
        if (email == data['email'] && password == data['password']) {
          name = data['name'];
          this.email = email;
          this.password = password;
          userExist = true;
        } else {
          userExist = false;
        }
      }
    } catch (e) {
      print('Exception catched: $e');
    }
    return userExist;
  }

  //Actualizar la información del archivo userToken.json
  Future<void> updateUserDataJSONFile(String name, String email) async {
    String path = await _getUserDataFilePath(); //Se obtiene la ruta del json
    File file = File(path);
    if (await file.exists()) {
      String response = await file.readAsString();
      final data = await json
          .decode(response); //Se obtiene el Json con el que se trabajará

      Map<String, dynamic> fakeJson = {
        "id": data["id"],
        'name': name,
        'email': email,
        'password': data["password"],
        "numNivel": data["numNivel"],
        "numPregunta": data["numPregunta"],
      };

      this.name = name;
      this.email = email;

      await createUserDataJSONFile(
          fakeJson); //Se sobrescribe el progreso actual
    }
  }

  Future<void> closeSession() async {
    id = "";
    name = "";
    email = "";
    password = "";
    numNivel = 0;
    numPregunta = 0;
    String path = await _getUserDataFilePath();
    File file = File(path);
    file.delete();
  }

/*bool userNotFound(String? errorMessage) {
    String? error = 'There is no user record corresponding to this identifier.';
    if (errorMessage!.contains(error)) {
      return true;
    } else {
      return false;
    }
  }

  bool emptyFields(String? errorMessage) {
    String? error = 'Given String is empty or null';
    if (errorMessage!.contains(error)) {
      return true;
    } else {
      return false;
    }
  }

  bool emailBadlyFormatted(String? errorMessage) {
    String? error = 'The email address is badly formatted.';
    if (errorMessage!.contains(error)) {
      return true;
    } else {
      return false;
    }
  }

  bool passwordBadlyFormatted(String? errorMessage) {
    String? error = 'Password should be at least 6 characters';
    if (errorMessage!.contains(error)) {
      return true;
    } else {
      return false;
    }
  }

  bool invalidData(String? errorMessage) {
    String? error = 'The password is invalid ';
    if (errorMessage!.contains(error)) {
      return true;
    } else {
      return false;
    }
  }*/
}
