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
        Builder(
          builder: (context) => IconButton(
            tooltip: 'Compartilhar',
            onPressed: () => actions.shareText(
              '${AppConstants.shareText}\n${AppConstants.defaultShareUrl}',
              subject: AppConstants.appName,
              sharePositionOrigin: ExternalActions.sharePositionOrigin(context),
            ),
            icon: const Icon(Icons.ios_share_rounded),
          ),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Text(
            'Sobre o Protege Saúde',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Tecnologia, saúde e rede de proteção trabalhando para orientar denúncias com mais clareza.',
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            title: 'Nossa Origem',
            text:
                'O Protege Saúde nasceu de um projeto de pesquisa do curso de Odontologia da UEPB, visando criar uma ferramenta para auxiliar profissionais da Saúde na identificação de violência contra crianças e adolescentes.',
          ),
          const _PartnersCard(),

          _InfoCard(
            title: 'Código Aberto',
            text:
                'O Protege Saúde é um projeto de código aberto, permitindo que a comunidade contribua para seu desenvolvimento e melhoria contínuos.',
            buttonLabel: 'Abrir GitHub',
            onPressed: () => actions.openUrl(AppConstants.githubUrl),
          ),
          _InfoCard(
            title: 'Processo Criativo',
            text:
                'O processo criativo por trás do desenvolvimento do Protege Saúde está documentado e disponível para visualização.',
            buttonLabel: 'Abrir YouTube',
            onPressed: () => actions.openUrl(AppConstants.creativeProcessUrl),
          ),
          Builder(
            builder: (context) => FilledButton.icon(
              onPressed: () => actions.shareText(
                '${AppConstants.shareText}\n${AppConstants.defaultShareUrl}',
                subject: AppConstants.appName,
                sharePositionOrigin: ExternalActions.sharePositionOrigin(
                  context,
                ),
              ),
              icon: const Icon(Icons.ios_share_rounded),
              label: const Text('Compartilhar o Protege Saúde'),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Todos os direitos reservados (c) Protege Saúde 2026',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
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
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: onPressed,
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text(buttonLabel!),
                ),
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
              'Este projeto é uma colaboração entre a UFCG e a UEPB, unindo experiência acadêmica e tecnológica para um propósito social.',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(AppAssets.ufcgLogo, height: 62),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(AppAssets.uepbLogo, height: 62),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
