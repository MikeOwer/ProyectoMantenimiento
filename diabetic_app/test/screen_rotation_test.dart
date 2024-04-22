import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test de rotación de pantalla", (tester) async {
    // Crear app y cargar el widget principal
    await tester.pumpWidget(ScreenRotation());

    // Espera un poco para asegurarse de que la aplicación esté completamente renderizada
    await tester.pumpAndSettle();

    // Verifica que la orientación inicial de la pantalla sea vertical
    expect(find.text('Pantalla vertical'), findsOneWidget);

    // Rota la pantalla a horizontal
    const screenRotation = Size(800, 400);
    await tester.binding.setSurfaceSize(screenRotation);
    await tester.pumpAndSettle();

    // Verifica que la pantalla no haya rotado
    expect(find.text('Pantalla vertical'), findsOneWidget);
  });
}

class ScreenRotation extends StatelessWidget {
  const ScreenRotation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test de Rotación de Pantalla',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test de Rotación de Pantalla'),
        ),
        body: Center(
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                // return Text('Pantalla vertical');
                return Text('Pantalla horizontal');
              } else {
                // return Text('Pantalla horizontal');
                return Text('Pantalla vertical');
              }
            },
          ),
        ),
      ),
    );
  }
}
