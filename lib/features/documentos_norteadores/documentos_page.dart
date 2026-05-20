import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/models/guide_document.dart';
import '../../shared/models/profession.dart';
import '../../shared/services/external_actions.dart';
import '../../shared/utils/color_utils.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/async_state_widgets.dart';
import '../../shared/widgets/searchable_select.dart';
import '../../shared/widgets/section_card.dart';
import 'controllers/documentos_controller.dart';

class DocumentosPage extends StatefulWidget {
  const DocumentosPage({super.key, this.autoLoad = true});

  final bool autoLoad;

  @override
  State<DocumentosPage> createState() => _DocumentosPageState();
}

class _DocumentosPageState extends State<DocumentosPage> {
  @override
  void initState() {
    super.initState();
    if (!widget.autoLoad) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DocumentosController>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Documentos Norteadores',
      body: Consumer<DocumentosController>(
        builder: (context, controller, _) {
          if (controller.isLoadingProfessions) {
            return const LoadingState(message: 'Carregando profissoes...');
          }
          if (controller.professionsError != null) {
            return ErrorState(
              message: controller.professionsError!,
              onRetry: controller.load,
            );
          }
          return _DocumentBody(controller: controller);
        },
      ),
    );
  }
}

class _DocumentBody extends StatelessWidget {
  const _DocumentBody({required this.controller});

  final DocumentosController controller;

  @override
  Widget build(BuildContext context) {
    final color = parseHexColor(controller.selectedProfession?.cor);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        Text(
          'Biblioteca de Documentos Legais',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        const Text(
          'Acesso a documentos importantes com foco em artigos especificos relevantes para profissionais.',
        ),
        const SizedBox(height: 16),
        SearchableSelect<Profession>(
          label: 'Profissao',
          items: controller.professions,
          itemLabel: (profession) => profession.nome,
          value: controller.selectedProfession,
          onSelected: controller.selectProfession,
        ),
        const SizedBox(height: 18),
        if (controller.selectedProfession == null)
          const SectionCard(
            child: Text('Selecione uma profissao para visualizar documentos.'),
          )
        else if (controller.isLoadingDocuments)
          const SizedBox(
            height: 220,
            child: LoadingState(message: 'Carregando documentos...'),
          )
        else if (controller.documentsError != null)
          SizedBox(
            height: 240,
            child: ErrorState(
              message: controller.documentsError!,
              onRetry: () =>
                  controller.selectProfession(controller.selectedProfession!),
            ),
          )
        else if (controller.documents.isEmpty)
          const SectionCard(child: Text('Nenhum documento encontrado.'))
        else
          for (final document in controller.documents) ...[
            _DocumentCard(document: document, color: color),
            const SizedBox(height: 12),
          ],
      ],
    );
  }
}

class _DocumentCard extends StatelessWidget {
  const _DocumentCard({required this.document, required this.color});

  final GuideDocument document;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DocumentosController>();
    final actions = context.read<ExternalActions>();
    final coverUrl = controller.normalizeUrl(document.fotoCapa);
    final coverAsset = controller.coverAssetFor(document);
    final downloadedPath = controller.downloadedPaths[document.id];
    final isDownloading = controller.downloading.contains(document.id);
    final canDownload = controller.canDownload(document);
    final onlineUrl = document.urlOnline?.trim();
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 170,
              width: double.infinity,
              child: coverUrl.isNotEmpty
                  ? Image.network(
                      coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _coverFallback(coverAsset),
                    )
                  : _coverFallback(coverAsset),
            ),
          ),
          const SizedBox(height: 12),
          Text(document.titulo, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            document.descricao?.trim().isNotEmpty == true
                ? document.descricao!
                : 'Sem descricao disponivel.',
          ),
          if (document.pontosFoco.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Pontos de foco',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            for (final point in document.pontosFoco)
              Text(
                point.pagina == null
                    ? '- ${point.titulo}'
                    : '- ${point.titulo} (pagina ${point.pagina})',
              ),
          ],
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (onlineUrl?.isNotEmpty == true)
                OutlinedButton.icon(
                  onPressed: () => actions.openUrl(onlineUrl!),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: const Text('Visualizar Online'),
                ),
              if (canDownload)
                FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: color),
                  onPressed: isDownloading
                      ? null
                      : () async {
                          final error = await controller.download(document);
                          if (!context.mounted) {
                            return;
                          }
                          if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error),
                                action: onlineUrl?.isNotEmpty == true
                                    ? SnackBarAction(
                                        label: 'Abrir online',
                                        onPressed: () =>
                                            actions.openUrl(onlineUrl!),
                                      )
                                    : null,
                              ),
                            );
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Download concluido')),
                          );
                        },
                  icon: isDownloading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.download_rounded),
                  label: Text(isDownloading ? 'Baixando...' : 'Download'),
                ),
              if (downloadedPath != null)
                TextButton.icon(
                  onPressed: () => actions.openFile(downloadedPath),
                  icon: const Icon(Icons.picture_as_pdf_rounded),
                  label: const Text('Abrir arquivo'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _coverFallback(String? asset) {
    if (asset != null) {
      return Image.asset(asset, fit: BoxFit.cover);
    }
    return Container(
      color: const Color(0xFFE7EFEC),
      child: const Center(child: Text('Sem capa')),
    );
  }
}
