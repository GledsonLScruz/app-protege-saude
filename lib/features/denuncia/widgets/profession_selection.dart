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
    required this.color,
    required this.onSelected,
    required this.onContinue,
  });

  final List<Profession> professions;
  final Profession? selected;
  final bool isLoadingForm;
  final String? formError;
  final Color color;
  final ValueChanged<Profession> onSelected;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Comece pela sua área de atuação',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text(
          'O formulário se adapta à profissão para pedir somente as informações necessárias.',
        ),
        const SizedBox(height: 16),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchableSelect<Profession>(
                label: 'Profissão',
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
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withValues(alpha: 0.28)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                selected!.nome,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(selected!.displayDescription),
                      ],
                    ),
                  ),
                ),
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
