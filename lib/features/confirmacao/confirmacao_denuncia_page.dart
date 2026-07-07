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

const _feedbackFormUrl = 'https://forms.gle/w5mmUvYX5vVS4Ufw7';

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

class _ConfirmationContent extends StatefulWidget {
  const _ConfirmationContent({required this.record});

  final ConfirmationRecord record;

  @override
  State<_ConfirmationContent> createState() => _ConfirmationContentState();
}

class _ConfirmationContentState extends State<_ConfirmationContent> {
  bool _didShowFeedbackDialog = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _showFeedbackDialog();
      }
    });
  }

  Future<void> _showFeedbackDialog() async {
    if (_didShowFeedbackDialog) {
      return;
    }
    _didShowFeedbackDialog = true;

    final shouldOpenForm = await showDialog<bool>(
      context: context,
      builder: (context) => const _PlatformFeedbackDialog(),
    );
    if (!mounted || shouldOpenForm != true) {
      return;
    }

    try {
      await context.read<ExternalActions>().openUrl(_feedbackFormUrl);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir o formulário de avaliação.'),
        ),
      );
    }
  }

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
                _Info(label: 'Protocolo', value: widget.record.protocol),
                _Info(label: 'Profissão', value: widget.record.professionName),
                if (widget.record.councilName?.isNotEmpty == true)
                  _Info(label: 'Conselho', value: widget.record.councilName!),
                _Info(
                  label: 'Enviado em',
                  value: formatDateTimeBr(widget.record.sentAt),
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
            onPressed: () => actions.openFile(widget.record.pdfPath),
            icon: const Icon(Icons.picture_as_pdf_rounded),
            label: const Text('Abrir PDF'),
          ),
          const SizedBox(height: 8),
          Builder(
            builder: (context) => OutlinedButton.icon(
              onPressed: () => actions.shareFile(
                widget.record.pdfPath,
                text: 'Denúncia ${widget.record.protocol}',
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
            onPressed: () => actions.printPdf(widget.record.pdfPath),
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

class _PlatformFeedbackDialog extends StatelessWidget {
  const _PlatformFeedbackDialog();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24, 12, 8, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 28, left: 24),
              child: Text(
                'Avalie nossa plataforma',
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Fechar',
            onPressed: () => Navigator.of(context).pop(false),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sua opinião é muito importante para continuarmos melhorando!',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Leva menos de 3 minutos para responder.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Avaliar agora'),
        ),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Mais tarde'),
        ),
      ],
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
