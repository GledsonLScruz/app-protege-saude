import 'package:flutter/material.dart';

import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/section_card.dart';

class PontosApoioPage extends StatelessWidget {
  const PontosApoioPage({super.key});

  static const districts = {
    'NORTE': ['Alto Branco', 'Lauritzen', 'Palmeira', 'Prata'],
    'SUL': ['Catole', 'Sandra Cavalcante', 'Itarare', 'Jardim Paulistano'],
    'LESTE': ['Liberdade', 'Jardim Quarenta', 'Centenario', 'Jose Pinheiro'],
    'OESTE': ['Bodocongo', 'Malvinas', 'Serrotao', 'Dinamica'],
  };

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Pontos de Apoio',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Text(
            'Pontos de Apoio a Denuncia',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          const SectionCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_rounded),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Santo Antonio, Campina Grande - PB, 58406-000'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Distritos do Conselho Tutelar',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final entry in districts.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SectionCard(
                padding: EdgeInsets.zero,
                child: ExpansionTile(
                  title: Text(entry.key),
                  leading: const Icon(Icons.map_rounded),
                  children: [
                    for (final neighborhood in entry.value)
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.circle, size: 8),
                        title: Text(neighborhood),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
