import 'package:flutter/material.dart';

import '../../../shared/models/profession.dart';
import '../../../shared/widgets/searchable_select.dart';
import '../../../shared/widgets/section_card.dart';

class ProfessionSelection extends StatelessWidget {
  const ProfessionSelection({
    super.key,
    required this.professions,
    required this.selected,
    required this.isLoadingForm,
    required this.formError,
    required this.onSelected,
    required this.onContinue,
  });

  final List<Profession> professions;
  final Profession? selected;
  final bool isLoadingForm;
  final String? formError;
  final ValueChanged<Profession> onSelected;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nova denuncia',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text('O conteudo da denuncia e configurado por profissao.'),
              const SizedBox(height: 16),
              SearchableSelect<Profession>(
                label: 'Profissao',
                items: professions,
                itemLabel: (profession) => profession.nome,
                value: selected,
                onSelected: onSelected,
              ),
              if (isLoadingForm) ...[
                const SizedBox(height: 12),
                const LinearProgressIndicator(),
              ],
              if (formError != null) ...[
                const SizedBox(height: 12),
                Text(
                  formError!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              if (selected != null) ...[
                const SizedBox(height: 16),
                Text(
                  selected!.nome,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(selected!.displayDescription),
              ],
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed:
                    selected != null && !isLoadingForm && formError == null
                    ? onContinue
                    : null,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
