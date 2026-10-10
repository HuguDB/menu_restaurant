import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:menu_restaurant/main.dart';

void main() {
  testWidgets('les 5 catégories s\'affichent', (tester) async {
    await tester.pumpWidget(const RestaurantApp());

    for (final c in ['Formules', 'Entrées', 'Plats', 'Desserts', 'Boissons']) {
      expect(find.widgetWithText(ChoiceChip, c), findsOneWidget);
    }
  });

  testWidgets('"Formules" est sélectionnée par défaut', (tester) async {
    await tester.pumpWidget(const RestaurantApp());

    final chip =
        tester.widget<ChoiceChip>(find.widgetWithText(ChoiceChip, 'Formules'));
    expect(chip.selected, isTrue);
    expect(find.text('Formule Midi'), findsOneWidget);
  });

  testWidgets('un tap sur "Desserts" affiche les desserts', (tester) async {
    await tester.pumpWidget(const RestaurantApp());

    await tester.tap(find.widgetWithText(ChoiceChip, 'Desserts'));
    await tester.pumpAndSettle();

    expect(find.text('Crème brûlée'), findsOneWidget);
    expect(find.text('Formule Midi'), findsNothing);
  });
}
