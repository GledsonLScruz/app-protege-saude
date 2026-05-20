import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/app_assets.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/services/external_actions.dart';
import '../../shared/widgets/app_logo.dart';
import '../../shared/widgets/section_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = context.read<ExternalActions>();
    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(height: 34),
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
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAssets.heroFather,
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'ProtegeSaude',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'O ProtegeSaude auxilia profissionais na identificacao e denuncia anonima de suspeitas de violencia e maus-tratos contra criancas e adolescentes.',
            ),
            const SizedBox(height: 18),
            _ActionCard(
              icon: Icons.report_problem_rounded,
              title: 'Realizar uma denuncia',
              description:
                  'Reportar casos suspeitos de violencia e maus-tratos.',
              onTap: () => _showAnonymousDialog(context),
            ),
            _ActionCard(
              icon: Icons.menu_book_rounded,
              title: 'Documentos Norteadores',
              description: 'Consultar documentos legais por profissao.',
              onTap: () => context.push('/documentos-norteadores'),
            ),
            _ActionCard(
              icon: Icons.location_on_rounded,
              title: 'Pontos de denuncia',
              description: 'Ver distritos e locais de apoio a denuncia.',
              onTap: () => context.push('/pontos-apoio'),
            ),
            _ActionCard(
              icon: Icons.info_rounded,
              title: 'Sobre o ProtegeSaude',
              description: 'Conhecer origem, parcerias e desenvolvimento.',
              onTap: () => context.push('/sobre'),
            ),
            _ActionCard(
              icon: Icons.health_and_safety_rounded,
              title: 'Identifique uma vitima',
              description: 'Funcionalidade em breve.',
              enabled: false,
              onTap: () => _soon(context),
            ),
            _ActionCard(
              icon: Icons.help_rounded,
              title: 'Duvidas frequentes',
              description: 'Perguntas comuns sobre denuncia e sigilo.',
              onTap: () {
                final faqContext = _faqKey.currentContext;
                if (faqContext != null) {
                  Scrollable.ensureVisible(
                    faqContext,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOut,
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            _EmergencyContacts(actions: actions),
            const SizedBox(height: 16),
            _FaqSection(key: _faqKey),
            const SizedBox(height: 16),
            const _Partners(),
          ],
        ),
      ),
    );
  }

  static final GlobalKey _faqKey = GlobalKey();

  Future<void> _showAnonymousDialog(BuildContext context) async {
    final proceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sua identidade esta protegida'),
        content: const Text(
          'A denuncia sera enviada de forma anonima. Informe apenas os dados necessarios para que o Conselho Tutelar responsavel possa avaliar o caso.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Voltar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Prosseguir com a denuncia'),
          ),
        ],
      ),
    );
    if (proceed == true && context.mounted) {
      context.push('/denuncia');
    }
  }

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Funcionalidade em breve')));
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SectionCard(
        onTap: enabled ? onTap : onTap,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: enabled
                  ? Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.12)
                  : Colors.grey.shade200,
              foregroundColor: enabled
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(description),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}

class _EmergencyContacts extends StatelessWidget {
  const _EmergencyContacts({required this.actions});

  final ExternalActions actions;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contatos de emergencia',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _ContactTile(
            text: 'Disque 100 - Direitos Humanos',
            onTap: () => actions.callPhone('100'),
          ),
          _ContactTile(
            text: 'Disque 180 - Violencia contra Mulher',
            onTap: () => actions.callPhone('180'),
          ),
          _ContactTile(
            text: 'Disque 190 - Policia Militar',
            onTap: () => actions.callPhone('190'),
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.phone_rounded),
      title: Text(text),
      onTap: onTap,
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        'Como faco para registrar uma denuncia?',
        'Para registrar uma denuncia, toque em Realizar uma denuncia e siga o fluxo. Todas as denuncias sao tratadas com sigilo.',
      ),
      (
        'Minha identidade sera mantida em sigilo?',
        'Sim. A denuncia no ProtegeSaude e anonima, e as informacoes fornecidas sao usadas apenas para encaminhamento do caso.',
      ),
      (
        'Que tipos de casos posso denunciar?',
        'Qualquer suspeita de violencia ou maus-tratos contra criancas e adolescentes, incluindo violencia fisica, psicologica, negligencia, abuso, violencia domestica e outras formas de agressao.',
      ),
      (
        'Como identificar sinais de violencia?',
        'Fique atento a lesoes inexplicadas, marcas recorrentes, comportamento muito ansioso ou temeroso, explicacoes inconsistentes sobre machucados e relutancia em responder perguntas.',
      ),
      (
        'O que acontece apos fazer uma denuncia?',
        'A denuncia e encaminhada ao Conselho Tutelar responsavel, que avaliara as informacoes e adotara as providencias cabiveis.',
      ),
      (
        'Preciso ter certeza absoluta para fazer uma denuncia?',
        'Nao. Se houver suspeita fundamentada, a denuncia pode ser feita. Os orgaos competentes sao responsaveis por investigar e confirmar os fatos.',
      ),
      (
        'Por que nao ha detalhamento pericial das partes do corpo?',
        'Porque o ProtegeSaude e uma ferramenta de apoio a denuncia, nao um recurso para realizacao de pericia das lesoes observadas.',
      ),
    ];
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Duvidas frequentes',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final item in items)
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(item.$1),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(item.$2),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Partners extends StatelessWidget {
  const _Partners();

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Parcerias', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: Image.asset(AppAssets.ufcgLogo, height: 72)),
              const SizedBox(width: 12),
              Expanded(child: Image.asset(AppAssets.uepbLogo, height: 72)),
            ],
          ),
        ],
      ),
    );
  }
}
