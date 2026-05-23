import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:protege_saude/features/denuncia/widgets/dynamic_form_step_view.dart';
import 'package:protege_saude/shared/models/complaint_models.dart';
import 'package:protege_saude/shared/models/public_form.dart';

void main() {
  testWidgets('campo CEP dinamico aplica mascara 00000-000', (tester) async {
    final step = PublicFormStep.fromJson({
      'id': 1,
      'titulo': 'Endereco complementar',
      'campos': [
        {'id': 10, 'nome': 'CEP do local', 'tipo_campo': 'cep'},
      ],
    });
    final answers = <int, Object?>{};

    await tester.pumpWidget(
      _TestHost(
        step: step,
        answerFor: (field) => answers[field.id],
        onChanged: (field, value) => answers[field.id] = value,
      ),
    );

    await tester.enterText(find.byKey(const ValueKey('10_cep')), '58406000');

    expect(find.text('58406-000'), findsOneWidget);
    expect(answers[10], '58406-000');
  });

  testWidgets('campo data dinamico aplica mascara dd/mm/aaaa', (tester) async {
    final step = PublicFormStep.fromJson({
      'id': 1,
      'titulo': 'Ocorrencia',
      'campos': [
        {'id': 10, 'nome': 'Data aproximada', 'tipo_campo': 'data'},
      ],
    });
    final answers = <int, Object?>{};

    await tester.pumpWidget(
      _TestHost(
        step: step,
        answerFor: (field) => answers[field.id],
        onChanged: (field, value) => answers[field.id] = value,
      ),
    );

    await tester.enterText(find.byKey(const ValueKey('10_data')), '21052026');

    expect(find.text('21/05/2026'), findsOneWidget);
    expect(answers[10], '21/05/2026');
  });

  testWidgets('switch condicional mostra somente opcoes permitidas', (
    tester,
  ) async {
    final step = PublicFormStep.fromJson({
      'id': 1,
      'titulo': 'Relato',
      'campos': [
        {
          'id': 11,
          'nome': 'Houve relato?',
          'tipo_campo': 'switch',
          'opcoes': [
            {'valor': 'permitida', 'label': 'Permitida'},
            {'valor': 'bloqueada', 'label': 'Bloqueada'},
          ],
          'validacoes': {
            'opcoes_condicionais_permitidas': ['permitida'],
          },
        },
      ],
    });

    await tester.pumpWidget(
      _TestHost(
        step: step,
        answerFor: (_) => {'valor': true, 'selecionados': <String>[]},
      ),
    );

    expect(find.text('Permitida'), findsOneWidget);
    expect(find.text('Bloqueada'), findsNothing);
  });

  testWidgets('campo de texto mostra dica como hint text', (tester) async {
    final step = PublicFormStep.fromJson({
      'id': 1,
      'titulo': 'Relato',
      'campos': [
        {
          'id': 12,
          'nome': 'Hematoma?',
          'tipo_campo': 'texto',
          'obrigatorio': true,
          'dica': 'Acumulo de sangue em um tecido.',
        },
      ],
    });

    await tester.pumpWidget(_TestHost(step: step, answerFor: (_) => null));

    expect(find.text('Acumulo de sangue em um tecido.'), findsOneWidget);
    expect(find.text('?'), findsNothing);
  });

  testWidgets(
    'dica de campo nao textual aparece ao tocar no icone da pergunta',
    (tester) async {
      final step = PublicFormStep.fromJson({
        'id': 1,
        'titulo': 'Relato',
        'campos': [
          {
            'id': 13,
            'nome': 'Houve relato?',
            'tipo_campo': 'switch',
            'obrigatorio': true,
            'dica': 'Marque quando houver relato confirmado.',
          },
        ],
      });

      await tester.pumpWidget(
        _TestHost(
          step: step,
          answerFor: (_) => {'valor': false, 'selecionados': <String>[]},
        ),
      );

      expect(find.text('?'), findsOneWidget);
      expect(
        find.text('Marque quando houver relato confirmado.'),
        findsNothing,
      );

      await tester.tap(find.text('?'));
      await tester.pumpAndSettle();

      expect(
        find.text('Marque quando houver relato confirmado.'),
        findsOneWidget,
      );

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(
        find.text('Marque quando houver relato confirmado.'),
        findsNothing,
      );
    },
  );
}

class _TestHost extends StatelessWidget {
  const _TestHost({
    required this.step,
    required this.answerFor,
    this.onChanged,
  });

  final PublicFormStep step;
  final Object? Function(PublicFormField field) answerFor;
  final void Function(PublicFormField field, Object? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DynamicFormStepView(
          step: step,
          color: const Color(0xFF24786B),
          answerFor: answerFor,
          errorFor: (_) => null,
          photosFor: (_) => const <PhotoRef>[],
          onChanged: onChanged ?? (_, _) {},
          onAddGallery: (_) async => null,
          onCapture: (_) async => null,
          onRemovePhoto: (_, _) async {},
        ),
      ),
    );
  }
}
