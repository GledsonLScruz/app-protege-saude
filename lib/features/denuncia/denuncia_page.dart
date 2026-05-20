// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../shared/utils/color_utils.dart';
import '../../shared/widgets/async_state_widgets.dart';
import '../../shared/widgets/app_scaffold.dart';
import 'controllers/denuncia_controller.dart';
import 'widgets/address_step.dart';
import 'widgets/dynamic_form_step_view.dart';
import 'widgets/profession_selection.dart';
import 'widgets/summary_step.dart';
import 'widgets/wizard_progress.dart';

class DenunciaPage extends StatefulWidget {
  const DenunciaPage({super.key});

  @override
  State<DenunciaPage> createState() => _DenunciaPageState();
}

class _DenunciaPageState extends State<DenunciaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DenunciaController>().loadProfessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DenunciaController>(
      builder: (context, controller, _) {
        final color = parseHexColor(
          controller.selectedProfession?.cor ??
              controller.pendingProfession?.cor,
        );
        if (!controller.wizardStarted) {
          return AppScaffold(
            title: 'Selecione a profissao',
            body: _selectionBody(context, controller),
          );
        }
        return WillPopScope(
          onWillPop: () => _confirmExit(context, controller),
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: controller.isSubmitting
                        ? null
                        : () => _handleRouteBack(context, controller),
                  ),
                  title: Text(controller.currentStepTitle),
                  actions: [
                    TextButton(
                      onPressed: controller.isSubmitting
                          ? null
                          : () async {
                              final canExit = await _confirmExit(
                                context,
                                controller,
                              );
                              if (!context.mounted) {
                                return;
                              }
                              if (canExit) {
                                controller.returnToProfessionSelection();
                              }
                            },
                      child: const Text('Trocar profissao'),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    WizardProgress(
                      titles: controller.stepTitles,
                      currentIndex: controller.currentStep,
                      isValid: controller.isStepValid,
                      isAccessible: controller.isStepAccessible,
                      onTap: controller.goToStep,
                      color: color,
                    ),
                    Expanded(child: _wizardBody(controller, color)),
                  ],
                ),
                bottomNavigationBar: _bottomBar(context, controller, color),
              ),
              if (controller.isSubmitting)
                Container(
                  color: Colors.black.withValues(alpha: 0.35),
                  child: const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text(
                              'Gerando PDF e transmitindo a denuncia...',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _selectionBody(BuildContext context, DenunciaController controller) {
    if (controller.isLoadingProfessions) {
      return const LoadingState(message: 'Carregando profissoes...');
    }
    if (controller.loadError != null) {
      return ErrorState(
        message: controller.loadError!,
        onRetry: controller.loadProfessions,
      );
    }
    return ProfessionSelection(
      professions: controller.professions,
      selected: controller.pendingProfession,
      isLoadingForm: controller.isLoadingForm,
      formError: controller.formError,
      onSelected: controller.selectProfession,
      onContinue: () => _handleProfessionContinue(context, controller),
    );
  }

  Future<void> _handleProfessionContinue(
    BuildContext context,
    DenunciaController controller,
  ) async {
    if (controller.availableDraft == null) {
      await controller.startFresh();
      return;
    }
    final restore = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Ha um rascunho salvo para ${controller.pendingProfession?.nome ?? 'esta profissao'}. Deseja retomar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Nao, comecar do zero'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sim, continuar rascunho'),
          ),
        ],
      ),
    );
    if (restore == true) {
      await controller.continueWithDraft();
    } else if (restore == false) {
      await controller.startFresh();
    }
  }

  Widget _wizardBody(DenunciaController controller, Color color) {
    if (controller.currentStep == 0) {
      return AddressStep(
        address: controller.address,
        isValidatingCep: controller.isValidatingCep,
        cepMessage: controller.cepMessage,
        cepError: controller.cepError,
        showErrors: controller.attemptedAdvance,
        onAddressChanged: controller.updateAddress,
        onValidateCep: controller.validateCep,
      );
    }
    if (controller.isSummaryStep) {
      return SummaryStep(
        address: controller.address,
        form: controller.loadedForm!,
        answers: controller.dynamicAnswers,
        photos: controller.photoRefs,
      );
    }
    final step = controller.currentDynamicStep!;
    return DynamicFormStepView(
      step: step,
      color: color,
      answerFor: (field) => controller.answerFor(step, field),
      errorFor: (field) => controller.fieldError(step, field),
      photosFor: (field) =>
          controller.photoRefs[field.id.toString()] ?? const [],
      onChanged: (field, value) => controller.updateAnswer(step, field, value),
      onAddGallery: controller.addPhotosFromGallery,
      onCapture: controller.capturePhoto,
      onRemovePhoto: controller.removePhoto,
    );
  }

  Widget _bottomBar(
    BuildContext context,
    DenunciaController controller,
    Color color,
  ) {
    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE0E8E5))),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.isSubmitting
                      ? null
                      : () async {
                          if (controller.currentStep == 0) {
                            final canExit = await _confirmExit(
                              context,
                              controller,
                            );
                            if (!context.mounted) {
                              return;
                            }
                            if (canExit) {
                              _popOrHome(context);
                            }
                          } else {
                            controller.previousStep();
                          }
                        },
                  child: Text(
                    controller.currentStep == 0
                        ? 'Voltar para tela inicial'
                        : 'Voltar',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: color),
                  onPressed: controller.isSubmitting
                      ? null
                      : () async {
                          if (!controller.isSummaryStep) {
                            controller.nextStep();
                            return;
                          }
                          final confirmation = await controller.submit();
                          if (!context.mounted) {
                            return;
                          }
                          if (confirmation != null) {
                            context.pushReplacement('/confirmacao-denuncia');
                          } else if (controller.submitError != null) {
                            await showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Erro ao enviar denuncia'),
                                content: Text(controller.submitError!),
                                actions: [
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                  child: Text(
                    controller.isSummaryStep ? 'Enviar Denuncia' : 'Proximo',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRouteBack(
    BuildContext context,
    DenunciaController controller,
  ) async {
    final canExit = await _confirmExit(context, controller);
    if (!context.mounted) {
      return;
    }
    if (canExit) {
      _popOrHome(context);
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

  Future<bool> _confirmExit(
    BuildContext context,
    DenunciaController controller,
  ) async {
    if (!controller.hasAnyData) {
      return true;
    }
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair da denuncia?'),
        content: const Text(
          'O rascunho sera mantido para voce continuar depois.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Continuar preenchendo'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sair mesmo assim'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
