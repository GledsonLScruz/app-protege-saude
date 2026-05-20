import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/app_assets.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/services/external_actions.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/section_card.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = context.read<ExternalActions>();
    return AppScaffold(
      title: 'Sobre',
      actions: [
        IconButton(
          tooltip: 'Compartilhar',
          onPressed: () => actions.shareText(
            '${AppConstants.shareText}\n${AppConstants.defaultShareUrl}',
            subject: AppConstants.appName,
          ),
          icon: const Icon(Icons.ios_share_rounded),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Text(
            'Sobre o ProtegeSaude',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Nossa Origem',
            text:
                'O ProtegeSaude nasceu de um projeto de extensao do curso de Odontologia da UEPB, visando criar uma ferramenta para auxiliar profissionais de saude na identificacao e denuncia de casos de maus-tratos e violencia contra criancas e adolescentes.',
          ),
          const _PartnersCard(),
          const _InfoCard(
            title: 'Desenvolvimento',
            text:
                'Desenvolvido por Huandrey Pontes, estudante da UFCG, como parte de seu TCC, aplicando teorias de UI para atender as necessidades dos profissionais de saude.',
          ),
          _InfoCard(
            title: 'Codigo Aberto',
            text:
                'O ProtegeSaude e um projeto de codigo aberto, permitindo que a comunidade contribua para seu desenvolvimento e melhoria continua.',
            buttonLabel: 'Abrir GitHub',
            onPressed: () => actions.openUrl(AppConstants.githubUrl),
          ),
          _InfoCard(
            title: 'Processo Criativo',
            text:
                'O processo criativo por tras do desenvolvimento do ProtegeSaude esta documentado e disponivel para visualizacao.',
            buttonLabel: 'Abrir YouTube',
            onPressed: () => actions.openUrl(AppConstants.creativeProcessUrl),
          ),
          FilledButton.icon(
            onPressed: () => actions.shareText(
              '${AppConstants.shareText}\n${AppConstants.defaultShareUrl}',
              subject: AppConstants.appName,
            ),
            icon: const Icon(Icons.ios_share_rounded),
            label: const Text('Compartilhar o ProtegeSaude'),
          ),
          const SizedBox(height: 18),
          const Text(
            'Todos os direitos reservados (c) ProtegeSaude 2024',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.text,
    this.buttonLabel,
    this.onPressed,
  });

  final String title;
  final String text;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(text),
            if (buttonLabel != null) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.open_in_new_rounded),
                label: Text(buttonLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PartnersCard extends StatelessWidget {
  const _PartnersCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Parcerias', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text(
              'Este projeto e uma colaboracao entre a UFCG e a UEPB, unindo experiencia academica e tecnologica para um proposito social.',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Image.asset(AppAssets.ufcgLogo, height: 70)),
                const SizedBox(width: 12),
                Expanded(child: Image.asset(AppAssets.uepbLogo, height: 70)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
