import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../shared/models/complaint_models.dart';
import '../../shared/persistence/draft_repository.dart';
import '../../shared/services/external_actions.dart';
import '../../shared/utils/date_utils.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/async_state_widgets.dart';
import '../../shared/widgets/section_card.dart';

class ConfirmacaoDenunciaPage extends StatelessWidget {
  const ConfirmacaoDenunciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<DraftRepository>();
    return FutureBuilder<ConfirmationRecord?>(
      future: repository.loadConfirmation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const AppScaffold(
            title: 'Confirmação',
            body: LoadingState(message: 'Carregando confirmação...'),
          );
        }
        final record = snapshot.data;
        if (record == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              _popOrHome(context);
            }
          });
          return const SizedBox.shrink();
        }
        return _ConfirmationContent(record: record);
      },
    );
  }
}

class _ConfirmationContent extends StatelessWidget {
  const _ConfirmationContent({required this.record});

  final ConfirmationRecord record;

  @override
  Widget build(BuildContext context) {
    final actions = context.read<ExternalActions>();
    return AppScaffold(
      title: 'Confirmação',
      canPop: false,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 28, 16, 32),
        children: [
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 54,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Denúncia enviada com sucesso',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 6),
          const Text(
            'O protocolo foi gerado e o PDF está disponível para consulta.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Info(label: 'Protocolo', value: record.protocol),
                _Info(label: 'Profissão', value: record.professionName),
                if (record.councilName?.isNotEmpty == true)
                  _Info(label: 'Conselho', value: record.councilName!),
                _Info(
                  label: 'Enviado em',
                  value: formatDateTimeBr(record.sentAt),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Guarde o protocolo para acompanhar ou referenciar a denúncia junto aos órgãos responsáveis.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => actions.openFile(record.pdfPath),
            icon: const Icon(Icons.picture_as_pdf_rounded),
            label: const Text('Abrir PDF'),
          ),
          const SizedBox(height: 8),
          Builder(
            builder: (context) => OutlinedButton.icon(
              onPressed: () => actions.shareFile(
                record.pdfPath,
                text: 'Denúncia ${record.protocol}',
                sharePositionOrigin: ExternalActions.sharePositionOrigin(
                  context,
                ),
              ),
              icon: const Icon(Icons.ios_share_rounded),
              label: const Text('Compartilhar PDF'),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => actions.printPdf(record.pdfPath),
            icon: const Icon(Icons.print_rounded),
            label: const Text('Salvar/Exportar PDF'),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.pushReplacement('/denuncia'),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Nova denúncia'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => _popOrHome(context),
            child: const Text('Voltar ao início'),
          ),
        ],
      ),
    );
  }
}

void _popOrHome(BuildContext context) {
  final router = GoRouter.maybeOf(context);
  if (router?.canPop() ?? false) {
    context.pop();
    return;
  }
  if (router != null) {
    context.pushReplacement('/');
    return;
  }
  Navigator.of(context).maybePop();
}

class _Info extends StatelessWidget {
  const _Info({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(value),
        ],
      ),
    );
  }
}
