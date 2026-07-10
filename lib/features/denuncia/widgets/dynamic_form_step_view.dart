// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/models/complaint_models.dart';
import '../../../shared/models/public_form.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/display_text.dart';
import '../../../shared/utils/text_normalizer.dart';
import '../../../shared/widgets/searchable_select.dart';

class DynamicFormStepView extends StatelessWidget {
  const DynamicFormStepView({
    super.key,
    required this.step,
    required this.color,
    required this.answerFor,
    required this.errorFor,
    required this.photosFor,
    required this.onChanged,
    required this.onAddGallery,
    required this.onCapture,
    required this.onRemovePhoto,
  });

  final PublicFormStep step;
  final Color color;
  final Object? Function(PublicFormField field) answerFor;
  final String? Function(PublicFormField field) errorFor;
  final List<PhotoRef> Function(PublicFormField field) photosFor;
  final void Function(PublicFormField field, Object? value) onChanged;
  final Future<String?> Function(PublicFormField field) onAddGallery;
  final Future<String?> Function(PublicFormField field) onCapture;
  final Future<void> Function(PublicFormField field, PhotoRef photo)
  onRemovePhoto;
  static const _contentPadding = EdgeInsets.fromLTRB(16, 16, 16, 128);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        padding: _contentPadding,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        children: [
          Text(
            accentPortugueseText(step.titulo),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (step.descricao?.trim().isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(accentPortugueseText(step.descricao!)),
          ],
          const SizedBox(height: 20),
          for (final field in step.campos) ...[
            _FieldShell(
              field: field,
              color: color,
              error: errorFor(field),
              child: _fieldWidget(context, field),
            ),
            const SizedBox(height: 18),
          ],
        ],
      ),
    );
  }

  Widget _fieldWidget(BuildContext context, PublicFormField field) {
    final value = answerFor(field);
    return switch (field.type) {
      'texto' => _textField(field, value),
      'textarea' => _textField(field, value, maxLines: 5),
      'numero' => _textField(
        field,
        value,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      'data' => _dateField(field, value),
      'cep' => _textField(
        field,
        formatCep(value?.toString() ?? ''),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          _CepInputFormatter(),
        ],
      ),
      'select' || 'bairro' => _selectField(field, value),
      'radio' => _radioField(field, value),
      'checkbox' => _checkboxField(field, value),
      'switch' => _switchField(field, value),
      'foto' => _photoField(context, field),
      _ => _textField(field, value),
    };
  }

  Widget _textField(
    PublicFormField field,
    Object? value, {
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      key: ValueKey('${field.id}_${field.type}'),
      initialValue: value?.toString() ?? '',
      minLines: maxLines > 1 ? maxLines : null,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: field.dica?.trim().isNotEmpty == true
            ? accentPortugueseText(field.dica!)
            : 'Digite sua resposta',
      ),
      onChanged: (text) => onChanged(field, text),
    );
  }

  Widget _dateField(PublicFormField field, Object? value) {
    return TextFormField(
      key: ValueKey('${field.id}_${field.type}'),
      initialValue: formatDateBr(value?.toString()),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _DateInputFormatter(),
      ],
      decoration: InputDecoration(
        hintText: field.dica?.trim().isNotEmpty == true
            ? accentPortugueseText(field.dica!)
            : 'dd/mm/aaaa',
        suffixIcon: const Icon(Icons.calendar_month_rounded),
      ),
      onChanged: (text) => onChanged(field, text),
    );
  }

  Widget _selectField(PublicFormField field, Object? value) {
    FormOption? selected;
    for (final option in field.opcoes) {
      if (option.valor == value?.toString()) {
        selected = option;
        break;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.type == 'bairro' &&
            (field.validacoes?.opcoesPermitidas.isNotEmpty ?? false))
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Chip(
              visualDensity: VisualDensity.compact,
              label: const Text('Bairro validado'),
              avatar: Icon(Icons.verified_rounded, color: color, size: 18),
            ),
          ),
        SearchableSelect<FormOption>(
          label: 'Selecione',
          items: field.opcoes,
          itemLabel: (option) => accentPortugueseText(option.label),
          value: selected,
          onSelected: (option) => onChanged(field, option.valor),
        ),
      ],
    );
  }

  Widget _radioField(PublicFormField field, Object? value) {
    return Column(
      children: field.opcoes
          .map(
            (option) => RadioListTile<String>(
              value: option.valor,
              groupValue: value?.toString(),
              onChanged: (selected) => onChanged(field, selected),
              title: Text(accentPortugueseText(option.label)),
              activeColor: color,
              contentPadding: EdgeInsets.zero,
            ),
          )
          .toList(),
    );
  }

  Widget _checkboxField(PublicFormField field, Object? value) {
    final selected = value is List
        ? value.map((item) => item.toString()).toSet()
        : <String>{};
    return Column(
      children: field.opcoes.map((option) {
        final checked = selected.contains(option.valor);
        return CheckboxListTile(
          value: checked,
          onChanged: (enabled) {
            final updated = {...selected};
            if (enabled ?? false) {
              updated.add(option.valor);
            } else {
              updated.remove(option.valor);
            }
            onChanged(field, updated.toList());
          },
          title: Text(accentPortugueseText(option.label)),
          activeColor: color,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }

  Widget _switchField(PublicFormField field, Object? value) {
    final map = value is Map ? value : const {};
    final boolValue = map['valor'] is bool ? map['valor'] as bool : null;
    final selected = map['selecionados'] is List
        ? (map['selecionados'] as List).map((item) => item.toString()).toSet()
        : <String>{};
    final conditionalOptions = field.conditionalOptions;
    void setSwitch(bool enabled) {
      onChanged(field, {'valor': enabled, 'selecionados': <String>[]});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          value: boolValue ?? false,
          onChanged: setSwitch,
          title: Text(boolValue == true ? 'Sim' : 'Não'),
          activeThumbColor: color,
          contentPadding: EdgeInsets.zero,
        ),
        if (boolValue == true && conditionalOptions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: color.withValues(alpha: 0.35)),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: conditionalOptions.map((option) {
                final checked = selected.contains(option.valor);
                return CheckboxListTile(
                  value: checked,
                  onChanged: (enabled) {
                    final updated = {...selected};
                    if (enabled ?? false) {
                      updated.add(option.valor);
                    } else {
                      updated.remove(option.valor);
                    }
                    onChanged(field, {
                      'valor': true,
                      'selecionados': updated.toList(),
                    });
                  },
                  title: Text(accentPortugueseText(option.label)),
                  activeColor: color,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _photoField(BuildContext context, PublicFormField field) {
    final photos = photosFor(field);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD7E1DE)),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF8FAF9),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${photos.length}/${field.resolvedMaxPhotos} fotos selecionadas',
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: () async {
                  final message = await onCapture(field);
                  if (context.mounted) {
                    _showPhotoMessage(context, message);
                  }
                },
                icon: const Icon(Icons.photo_camera_rounded),
                label: const Text('Câmera'),
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  final message = await onAddGallery(field);
                  if (context.mounted) {
                    _showPhotoMessage(context, message);
                  }
                },
                icon: const Icon(Icons.photo_library_rounded),
                label: const Text('Galeria'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (photos.isEmpty)
            const Text('Nenhuma foto selecionada.')
          else
            Column(
              children: photos
                  .map(
                    (photo) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                File(photo.localPath),
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => const SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: Text('Imagem indisponível.'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              photo.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: () => onRemovePhoto(field, photo),
                                icon: const Icon(Icons.delete_outline_rounded),
                                label: const Text('Remover'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  void _showPhotoMessage(BuildContext context, String? message) {
    if (message == null) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = formatCep(onlyDigits(newValue.text));
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _FieldShell extends StatelessWidget {
  const _FieldShell({
    required this.field,
    required this.color,
    required this.child,
    this.error,
  });

  final PublicFormField field;
  final Color color;
  final Widget child;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(field: field, color: color),
        const SizedBox(height: 8),
        child,
        if (error != null) ...[
          const SizedBox(height: 6),
          Text(
            error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.field, required this.color});

  final PublicFormField field;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );
    final hint = _usesInlineHint(field) ? null : field.dica?.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: labelStyle,
                children: [
                  TextSpan(text: accentPortugueseText(field.nome)),
                  if (field.isRequired)
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                ],
              ),
            ),
            if (hint?.isNotEmpty == true)
              _QuestionHint(color: color, message: accentPortugueseText(hint!)),
          ],
        ),
      ],
    );
  }
}

bool _usesInlineHint(PublicFormField field) {
  return switch (field.type) {
    'texto' || 'textarea' || 'numero' || 'data' || 'cep' => true,
    _ => false,
  };
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = onlyDigits(newValue.text);
    final limited = digits.length > 8 ? digits.substring(0, 8) : digits;
    final buffer = StringBuffer();
    for (var index = 0; index < limited.length; index++) {
      if (index == 2 || index == 4) {
        buffer.write('/');
      }
      buffer.write(limited[index]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _QuestionHint extends StatefulWidget {
  const _QuestionHint({required this.color, required this.message});

  final Color color;
  final String message;

  @override
  State<_QuestionHint> createState() => _QuestionHintState();
}

class _QuestionHintState extends State<_QuestionHint>
    with SingleTickerProviderStateMixin {
  final GlobalKey _buttonKey = GlobalKey();
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  OverlayEntry? _overlayEntry;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      reverseDuration: const Duration(milliseconds: 120),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _removeOverlay(immediate: true);
    _controller.dispose();
    super.dispose();
  }

  void _showOverlay() {
    _dismissTimer?.cancel();
    final overlayState = Overlay.maybeOf(context, rootOverlay: true);
    final buttonRenderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    final overlayRenderBox =
        overlayState?.context.findRenderObject() as RenderBox?;

    if (overlayState == null ||
        buttonRenderBox == null ||
        overlayRenderBox == null) {
      return;
    }

    const screenMargin = 16.0;
    const tooltipGap = 10.0;
    final overlaySize = overlayRenderBox.size;
    final buttonOffset = buttonRenderBox.localToGlobal(
      Offset.zero,
      ancestor: overlayRenderBox,
    );
    final buttonSize = buttonRenderBox.size;
    final availableWidth = overlaySize.width - (screenMargin * 2);
    final tooltipWidth = availableWidth < 220
        ? availableWidth
        : availableWidth > 340
        ? 340.0
        : availableWidth;
    final desiredLeft =
        buttonOffset.dx + (buttonSize.width / 2) - (tooltipWidth / 2);
    final maxLeft = overlaySize.width - tooltipWidth - screenMargin;
    final left = desiredLeft
        .clamp(screenMargin, maxLeft < screenMargin ? screenMargin : maxLeft)
        .toDouble();
    final bottom = overlaySize.height - buttonOffset.dy + tooltipGap;

    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: left,
          bottom: bottom,
          width: tooltipWidth,
          child: IgnorePointer(
            child: _HintTooltip(
              message: widget.message,
              fadeAnimation: _fadeAnimation,
              scaleAnimation: _scaleAnimation,
            ),
          ),
        ),
      );
      overlayState.insert(_overlayEntry!);
    }

    _controller.forward(from: 0);
    _dismissTimer = Timer(const Duration(seconds: 4), () => _removeOverlay());
  }

  Future<void> _removeOverlay({bool immediate = false}) async {
    _dismissTimer?.cancel();
    _dismissTimer = null;

    final entry = _overlayEntry;
    if (entry == null) {
      return;
    }

    if (!immediate && mounted) {
      await _controller.reverse();
    }
    entry.remove();
    if (_overlayEntry == entry) {
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Mostrar dica da pergunta',
      child: Material(
        color: Colors.transparent,
        child: InkResponse(
          onTap: _showOverlay,
          radius: 22,
          customBorder: const CircleBorder(),
          child: SizedBox.square(
            key: _buttonKey,
            dimension: 44,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HintTooltip extends StatelessWidget {
  const _HintTooltip({
    required this.message,
    required this.fadeAnimation,
    required this.scaleAnimation,
  });

  final String message;
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFF143642),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.16)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 24,
                    offset: Offset(0, 14),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ),
            ),
            ClipPath(
              clipper: const _TooltipArrowClipper(),
              child: ColoredBox(
                color: const Color(0xFF143642),
                child: const SizedBox(width: 18, height: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TooltipArrowClipper extends CustomClipper<Path> {
  const _TooltipArrowClipper();

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(_TooltipArrowClipper oldClipper) => false;
}
