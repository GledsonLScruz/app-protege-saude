import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:protege_saude/features/denuncia/widgets/wizard_progress.dart';

void main() {
  testWidgets('progresso do wizard cabe com onze etapas em largura compacta', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(402, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WizardProgress(
            titles: List.generate(11, (index) => 'Etapa ${index + 1}'),
            currentIndex: 0,
            isValid: (_) => true,
            isAccessible: (_) => true,
            onTap: (_) {},
            color: Colors.teal,
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
