import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'El sizebox que contiene el ícono de flecha no tiene funciones onTap',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    // Esta acción no debería ocurrir
                    print('GestureDetector tocado');
                  },
                ),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Noticias'),
                    SizedBox(width: 15),
                    Icon(Icons.arrow_downward),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Verifica que no haya ningún GestureDetector dentro del SizedBox
    // Verifica que haya un GestureDetector dentro del SizedBox
    expect(
        find.descendant(
          of: find.byType(SizedBox),
          matching: find.byType(GestureDetector),
        ),
        findsNothing);
  });
}
