import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protege_saude/shared/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/app_assets.dart';
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
        title: const AppLogo(height: 54),
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        toolbarHeight: 72,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          children: [
            _HeroPanel(onReport: () => _showAnonymousDialog(context)),
            const SizedBox(height: 16),
            _EmergencyContacts(actions: actions),
            const SizedBox(height: 16),
            Text(
              'Acesso rápido',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            _ActionCard(
              icon: Icons.report_problem_rounded,
              title: 'Realizar uma denúncia',
              description:
                  'Reportar casos suspeitos de violência e maus-tratos.',
              onTap: () => _showAnonymousDialog(context),
              primary: true,
            ),
            _ActionCard(
              icon: Icons.menu_book_rounded,
              title: 'Documentos Norteadores',
              description: 'Consultar documentos legais por profissão.',
              onTap: () => context.push('/documentos-norteadores'),
            ),
            _ActionCard(
              icon: Icons.info_rounded,
              title: 'Sobre o ProtegeSaude',
              description: 'Conhecer origem, parcerias e desenvolvimento.',
              onTap: () => context.push('/sobre'),
            ),
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
        title: const Text('Sua identidade está protegida'),
        content: const Text(
          'A denúncia será enviada de forma anônima. Informe apenas os dados necessários para que o Conselho Tutelar responsável possa avaliar o caso.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Voltar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Prosseguir com a denúncia'),
          ),
        ],
      ),
    );
    if (proceed == true && context.mounted) {
      context.push('/denuncia');
    }
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.onReport});

  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 292,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.heroFather, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x44143642),
                    Color(0x88143642),
                    Color(0xEE143642),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Text(
                        'Denúncia anônima e orientada',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'ProtegeSaude',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apoio simples para profissionais registrarem suspeitas de violência contra crianças e adolescentes.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.94),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: onReport,
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Iniciar denúncia'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.primary = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SectionCard(
        padding: const EdgeInsets.all(14),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppTheme.primary),
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
            Icon(
              primary
                  ? Icons.arrow_forward_rounded
                  : Icons.chevron_right_rounded,
              color: Colors.grey,
            ),
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
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.phone_in_talk_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Contatos de emergência',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _ContactTile(
            text: 'Disque 100 - Direitos Humanos',
            onTap: () => actions.callPhone('100'),
          ),
          _ContactTile(
            text: 'Disque 180 - Violência contra Mulher',
            onTap: () => actions.callPhone('180'),
          ),
          _ContactTile(
            text: 'Disque 190 - Polícia Militar',
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
      minVerticalPadding: 4,
      leading: const Icon(Icons.phone_rounded),
      title: Text(text),
      trailing: const Icon(Icons.chevron_right_rounded),
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
        'Como faço para registrar uma denúncia?',
        'Para registrar uma denúncia, toque em Realizar uma denúncia e siga o fluxo. Todas as denúncias são tratadas com sigilo.',
      ),
      (
        'Minha identidade será mantida em sigilo?',
        'Sim. A denúncia no ProtegeSaude é anônima, e as informações fornecidas são usadas apenas para encaminhamento do caso.',
      ),
      (
        'Que tipos de casos posso denunciar?',
        'Qualquer suspeita de violência ou maus-tratos contra crianças e adolescentes, incluindo violência física, psicológica, negligência, abuso, violência doméstica e outras formas de agressão.',
      ),
      (
        'Como identificar sinais de violência?',
        'Fique atento a lesões inexplicadas, marcas recorrentes, comportamento muito ansioso ou temeroso, explicações inconsistentes sobre machucados e relutância em responder perguntas.',
      ),
      (
        'O que acontece após fazer uma denúncia?',
        'A denúncia é encaminhada ao Conselho Tutelar responsável, que avaliará as informações e adotará as providências cabíveis.',
      ),
      (
        'Preciso ter certeza absoluta para fazer uma denúncia?',
        'Não. Se houver suspeita fundamentada, a denúncia pode ser feita. Os órgãos competentes são responsáveis por investigar e confirmar os fatos.',
      ),
      (
        'Por que não há detalhamento pericial das partes do corpo?',
        'Porque o ProtegeSaude é uma ferramenta de apoio à denúncia, não um recurso para realização de perícia das lesões observadas.',
      ),
    ];
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dúvidas frequentes',
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
          Text('Parcerias', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: Image.asset(AppAssets.ufcgLogo, height: 72)),
              const SizedBox(width: 12),
              Expanded(child: Image.asset(AppAssets.uepbLogo, height: 72)),
            ],
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
