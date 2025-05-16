import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:silentverce/main.dart';  // замени 'silentverce' на имя своего пакета

void main() {
  testWidgets('SilentverceApp loads without errors', (WidgetTester tester) async {
    // Построить виджет приложения и запустить первый кадр
    await tester.pumpWidget(const SilentverceApp());

    // Проверить, что показывается индикатор загрузки (CircularProgressIndicator)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Здесь можно добавить более сложные проверки по мере развития проекта
  });
}
