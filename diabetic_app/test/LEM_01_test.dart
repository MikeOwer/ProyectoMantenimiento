import 'package:diabetic_app/my_widgets/question_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Se debe ver si al estar en una posición menor a la del currentQuestion el botón se bloquea',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester
        .pumpWidget(QuestionButtonForTest(currentQuestion: 3, position: 2));

    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
        isFalse);
  });
}
