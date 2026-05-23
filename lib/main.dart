import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'features/confirmacao/confirmacao_denuncia_page.dart';
import 'features/denuncia/controllers/denuncia_controller.dart';
import 'features/denuncia/denuncia_page.dart';
import 'features/documentos_norteadores/controllers/documentos_controller.dart';
import 'features/documentos_norteadores/documentos_page.dart';
import 'features/home/home_page.dart';
import 'features/sobre/sobre_page.dart';
import 'shared/config/api_config.dart';
import 'shared/constants/app_constants.dart';
import 'shared/network/api_client.dart';
import 'shared/network/public_api.dart';
import 'shared/persistence/draft_repository.dart';
import 'shared/services/document_file_service.dart';
import 'shared/services/external_actions.dart';
import 'shared/services/pdf_service.dart';
import 'shared/services/photo_service.dart';
import 'shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = ApiConfig.fromEnvironment();
  final apiClient = ApiClient(config: config);
  final publicApi = PublicApi(apiClient);
  final draftRepository = DraftRepository();
  await draftRepository.init();
  runApp(
    ProtegeSaudeApp(
      apiClient: apiClient,
      publicApi: publicApi,
      draftRepository: draftRepository,
    ),
  );
}

class ProtegeSaudeApp extends StatelessWidget {
  const ProtegeSaudeApp({
    super.key,
    required this.apiClient,
    required this.publicApi,
    required this.draftRepository,
  });

  final ApiClient apiClient;
  final PublicApi publicApi;
  final DraftRepository draftRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        Provider<PublicApi>.value(value: publicApi),
        Provider<DraftRepository>.value(value: draftRepository),
        Provider(create: (_) => PdfService()),
        Provider(create: (_) => PhotoService()),
        Provider(create: (_) => ExternalActions()),
        Provider(
          create: (_) =>
              DocumentFileService(client: apiClient, publicApi: publicApi),
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = _buildRouter(context);
          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            routerConfig: router,
          );
        },
      ),
    );
  }

  GoRouter _buildRouter(BuildContext context) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: 'denuncia',
          path: '/denuncia',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => DenunciaController(
              api: context.read<PublicApi>(),
              draftRepository: context.read<DraftRepository>(),
              pdfService: context.read<PdfService>(),
              photoService: context.read<PhotoService>(),
            ),
            child: const DenunciaPage(),
          ),
        ),
        GoRoute(
          name: 'confirmacao-denuncia',
          path: '/confirmacao-denuncia',
          builder: (context, state) => const ConfirmacaoDenunciaPage(),
        ),
        GoRoute(
          name: 'documentos-norteadores',
          path: '/documentos-norteadores',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => DocumentosController(
              api: context.read<PublicApi>(),
              fileService: context.read<DocumentFileService>(),
            ),
            child: const DocumentosPage(),
          ),
        ),
        GoRoute(
          name: 'documentos-norteadores-profissao',
          path: '/documentos-norteadores/:profissaoId',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => DocumentosController(
              api: context.read<PublicApi>(),
              fileService: context.read<DocumentFileService>(),
              initialProfessionId: int.tryParse(
                state.pathParameters['profissaoId'] ?? '',
              ),
            ),
            child: const DocumentosPage(),
          ),
        ),
        GoRoute(
          name: 'sobre',
          path: '/sobre',
          builder: (context, state) => const SobrePage(),
        ),
      ],
    );
  }
}
