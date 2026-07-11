import 'package:flutter/material.dart';

class WizardProgress extends StatelessWidget {
  const WizardProgress({
    super.key,
    required this.titles,
    required this.currentIndex,
    required this.isValid,
    required this.isAccessible,
    required this.onTap,
    required this.color,
  });

  final List<String> titles;
  final int currentIndex;
  final bool Function(int index) isValid;
  final bool Function(int index) isAccessible;
  final ValueChanged<int> onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (titles.isEmpty) {
      return const SizedBox.shrink();
    }

    final activeIndex = currentIndex.clamp(0, titles.length - 1).toInt();
    final title = titles[activeIndex];

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 520;
            final preferredCircleSize = compact ? 34.0 : 42.0;
            final circleSize = _dotSizeForWidth(
              availableWidth: constraints.maxWidth,
              stepCount: titles.length,
              preferredSize: preferredCircleSize,
            );
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    for (var index = 0; index < titles.length; index++) ...[
                      _StepDot(
                        index: index,
                        title: titles[index],
                        size: circleSize,
                        color: color,
                        active: index == currentIndex,
                        complete: index < currentIndex,
                        accessible: isAccessible(index),
                        onTap: () => onTap(index),
                      ),
                      if (index < titles.length - 1)
                        Expanded(
                          child: _StepConnector(
                            active: index < currentIndex,
                            color: color,
                          ),
                        ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                _ActiveStepLabel(
                  title: title,
                  activeIndex: activeIndex,
                  totalSteps: titles.length,
                  circleSize: circleSize,
                  compact: compact,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _dotSizeForWidth({
    required double availableWidth,
    required int stepCount,
    required double preferredSize,
  }) {
    if (stepCount <= 0 || availableWidth <= 0) {
      return preferredSize;
    }

    final maxDotSize = availableWidth / stepCount;
    if (maxDotSize < 24.0) {
      return maxDotSize;
    }

    return preferredSize.clamp(24.0, maxDotSize).toDouble();
  }
}

class _ActiveStepLabel extends StatelessWidget {
  const _ActiveStepLabel({
    required this.title,
    required this.activeIndex,
    required this.totalSteps,
    required this.circleSize,
    required this.compact,
  });

  final String title;
  final int activeIndex;
  final int totalSteps;
  final double circleSize;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle =
        theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700);
    final maxLabelWidth = compact ? 132.0 : 180.0;

    return SizedBox(
      height: compact ? 40 : 24,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final available = constraints.maxWidth;
          final connectorWidth = totalSteps <= 1
              ? 0.0
              : (available - (totalSteps * circleSize)) / (totalSteps - 1);
          final stepDistance =
              circleSize + connectorWidth.clamp(0.0, double.infinity);
          final activeCenter = (circleSize / 2) + (activeIndex * stepDistance);
          final labelWidth = _measureLabelWidth(
            context: context,
            text: title,
            style: textStyle,
            maxWidth: maxLabelWidth.clamp(0.0, available),
          );
          final preferredLeft = activeCenter - (labelWidth / 2);
          final maxLeft = available - labelWidth;
          final left = preferredLeft.clamp(0.0, maxLeft);

          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                left: left,
                width: labelWidth,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: Text(
                    title,
                    key: ValueKey(title),
                    maxLines: compact ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double _measureLabelWidth({
    required BuildContext context,
    required String text,
    required TextStyle style,
    required double maxWidth,
  }) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: compact ? 2 : 1,
      textDirection: Directionality.of(context),
    )..layout(maxWidth: maxWidth);
    return (painter.width + 8).clamp(44.0, maxWidth);
  }
}

class _StepConnector extends StatelessWidget {
  const _StepConnector({required this.active, required this.color});

  final bool active;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 4,
      decoration: BoxDecoration(
        color: active ? color : Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.index,
    required this.title,
    required this.size,
    required this.color,
    required this.active,
    required this.complete,
    required this.accessible,
    required this.onTap,
  });

  final int index;
  final String title;
  final double size;
  final Color color;
  final bool active;
  final bool complete;
  final bool accessible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onColor = color.computeLuminance() > 0.45
        ? theme.colorScheme.onSurface
        : Colors.white;
    final fillColor = active || complete ? color : theme.colorScheme.surface;
    final borderColor = active || complete
        ? color
        : theme.colorScheme.outlineVariant;
    final foreground = active || complete
        ? onColor
        : theme.colorScheme.onSurface.withValues(alpha: 0.72);

    return Tooltip(
      message: title,
      child: Semantics(
        button: true,
        enabled: accessible,
        selected: active,
        label: 'Etapa ${index + 1}: $title',
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: accessible ? onTap : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: fillColor,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: active ? 2 : 1.4),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.2),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: FittedBox(
              child: Text(
                '${index + 1}',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
